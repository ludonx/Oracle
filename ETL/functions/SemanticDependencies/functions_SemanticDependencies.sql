CREATE OR REPLACE FUNCTION VERIFDF(tableName IN VARCHAR2,
 DR_SemanticDependencies IN VARCHAR2,
  LEFTCOL IN VARCHAR2,
  RIGHTCOL IN VARCHAR2)
    RETURN VARCHAR2
AS
myQuery VARCHAR2(500);
LISTAVERIFIER_VP0 VARCHAR2(500);
LISTAVERIFIER_VP VARCHAR2(500);
VERIFDF_VP VARCHAR2(500);
PERCENTAGE NUMBER;
X NUMBER;
Y NUMBER;
SemanticDependency VARCHAR2(5);
maxocc NUMBER;
inter NUMBER;
BEGIN
    LISTAVERIFIER_VP0 := 'LISTAVERIFIER_VP0';
    LISTAVERIFIER_VP := 'LISTAVERIFIER_VP';
    VERIFDF_VP := 'VERIFDF_VP';

    myQuery := 'CREATE OR REPLACE VIEW '||LISTAVERIFIER_VP0
    ||' ('||LEFTCOL||', '||RIGHTCOL||')AS SELECT '
    ||LEFTCOL||', '||RIGHTCOL||' FROM '||tableName;
    EXECUTE IMMEDIATE myQuery;

    myQuery := 'CREATE OR REPLACE VIEW '||LISTAVERIFIER_VP
    ||' ('||LEFTCOL||', '||RIGHTCOL||')AS SELECT DISTINCT * FROM '
    ||LISTAVERIFIER_VP0;
    EXECUTE IMMEDIATE myQuery;


    myQuery := 'CREATE OR REPLACE VIEW '||VERIFDF_VP
    ||' ('||LEFTCOL||',NBROCC )AS SELECT '||LEFTCOL
    ||', COUNT(*) FROM '||LISTAVERIFIER_VP
    ||' GROUP BY '||LEFTCOL
    ||' ORDER BY '||LEFTCOL;
    EXECUTE IMMEDIATE myQuery;


    X := 0;
    myQuery := 'SELECT COUNT(NBROCC) FROM '||VERIFDF_VP||' WHERE NBROCC >1' ;
    EXECUTE IMMEDIATE myQuery INTO X;

    IF X > 0 THEN
        myQuery := 'SELECT SUM(NBROCC) FROM '||VERIFDF_VP||' WHERE NBROCC >1' ;
        EXECUTE IMMEDIATE myQuery INTO X;
    END IF;

    myQuery := 'SELECT COUNT(*) FROM '||tableName;
    EXECUTE IMMEDIATE myQuery INTO Y;

    myQuery := 'SELECT MAX(NBROCC) FROM '||VERIFDF_VP;
    EXECUTE IMMEDIATE myQuery INTO maxocc;

    ----------------------------------------------------------------------------------
    --IF PERCENTAGE = 100 THEN  ? --OR // NOP
    -- DF
    IF maxocc > 1 THEN
        SemanticDependency := '-DF-';
    ELSE
        
        myQuery := 'SELECT COUNT(*) FROM '||tableName
        ||' WHERE UPPER (CAST('||LEFTCOL||' AS VARCHAR2(10))) = UPPER (CAST('||RIGHTCOL||' AS VARCHAR2(10)))';
        EXECUTE IMMEDIATE myQuery INTO maxocc;
        -- EQ
        IF maxocc > 0 THEN
          SemanticDependency := '-EQ-';
        ELSE
          myQuery := 'SELECT COUNT(*) FROM '||tableName
          ||' WHERE UPPER ( CAST('||LEFTCOL||' AS VARCHAR2(10)) ) > UPPER ( CAST('||RIGHTCOL||' AS VARCHAR2(10)) ) ';
          EXECUTE IMMEDIATE myQuery INTO maxocc;
          -- GE
          IF maxocc > 0 THEN
            SemanticDependency := '-GE-';
          ELSE
            SemanticDependency := '-LE-';
          END IF;
        END IF;
        X := maxocc;
    END IF;
    ----------------------------------------------------------------------------------

    PERCENTAGE := (1 - X/Y) * 100;

    myQuery := ' SELECT COUNT(*) FROM '||DR_SemanticDependencies
    ||' WHERE tableName = '''|| tableName
    ||''' AND LEFTCOL = ''' || LEFTCOL
    || ''' AND SemanticDependency = '''||SemanticDependency
    ||''' AND RIGHTCOL = '''||RIGHTCOL
    ||''' AND PERCENTAGE = '||ROUND(PERCENTAGE);
    --print_debug('----'||maxocc);
    EXECUTE IMMEDIATE myQuery INTO inter ;
    IF inter = 0 THEN
         myQuery := 'INSERT INTO '||DR_SemanticDependencies
            ||' VALUES ( '''|| tableName
            ||''' , ''' || LEFTCOL
            || ''' , '''||SemanticDependency
            ||''' , '''||RIGHTCOL
            ||''', '||ROUND(PERCENTAGE)||')';
        --print_debug(myQuery);
        EXECUTE IMMEDIATE myQuery ;

    ELSE
        SemanticDependency := 'EXT!';
        print_debug(SemanticDependency);
    END IF;

    print_debug (' ----- ['|| LEFTCOL ||' ('||SemanticDependency||','|| ROUND(PERCENTAGE)||'%) '||RIGHTCOL||' ]');
    RETURN (PERCENTAGE);
END;
/





CREATE OR REPLACE PROCEDURE VERIFDF_TAB(tableName IN VARCHAR2,
 DR_SemanticDependencies IN VARCHAR2)
 AS

  table_cursor SYS_REFCURSOR;
  table_cursor2 SYS_REFCURSOR;
  myQuery VARCHAR2(500);

  selected_values VARCHAR2(500);
  where_conditions VARCHAR2(500);

  LEFTCOL VARCHAR2(500);
  RIGHTCOL VARCHAR2(500);

  tableName_name VARCHAR2(500);
  LEFTCOL_name VARCHAR2(500);
  RIGHTCOL_name VARCHAR2(500);
  SEMANTICDEPENDENCY_name VARCHAR2(500);
  PERCENTAGE_name VARCHAR2(500);

  pct NUMBER;
  myQuery_RIGHTCOL VARCHAR2(500);
  myQuery_LEFTCOL VARCHAR2(500);

  nbrCol  NUMBER;
  maxCol  NUMBER;
BEGIN
  print_debug (' +---------------------------------------------------------------------+ ');
  print_debug (' [ DETECT SEMANTIC DEPENDENCIES ] ');
  --- on supprimer la semantic de la table passé en paramètre
  myQuery := 'DELETE FROM '||DR_SemanticDependencies||' WHERE tableName = '''||tableName||'''';
  EXECUTE IMMEDIATE myQuery ;
  --print_debug(myQuery);
  --- cette requête permet de récupérer les colonnes qu'une table passer en paramètres
  selected_values := ' COLUMN_NAME ';
  where_conditions := ' where table_name = '''||upper(tableName)||''' ';
  --where_conditions := ' where table_name = '''||upper(tableName)||''' AND DATA_TYPE = ''VARCHAR2''';
  myQuery_LEFTCOL := 'SELECT '|| selected_values ||' FROM user_tab_columns'|| where_conditions;
  myQuery_RIGHTCOL := myQuery_LEFTCOL;

  myQuery := 'SELECT COUNT(*) FROM user_tab_columns'|| where_conditions;
  EXECUTE IMMEDIATE myQuery INTO maxCol;
  --- pour chaque colonne récupérée, je fait la verification des DF
  nbrCol := 0;
  open table_cursor for myQuery_LEFTCOL;
    loop
      fetch table_cursor into LEFTCOL ;
      EXIT when table_cursor%NOTFOUND OR nbrCol = maxCol - 1 ;
      -------------------------------------------
      open table_cursor2 for myQuery_RIGHTCOL;
        loop
          fetch table_cursor2 into RIGHTCOL ;
          EXIT when table_cursor2%NOTFOUND;
          --print_debug(RIGHTCOL);
          IF LEFTCOL NOT LIKE RIGHTCOL THEN

            --pct := VERIFDF(tableName,DR_SemanticDependencies,LEFTCOL,'COL2_NAMES');
            pct := VERIFDF(tableName,DR_SemanticDependencies,LEFTCOL,RIGHTCOL);
            
            --print_debug(LEFTCOL || '-------' || RIGHTCOL || '--' || pct);
          END IF;
        end loop;
      close table_cursor2;
      --------------------------------------------
      nbrCol := nbrCol +1;
    end loop;
  close table_cursor;
  ----------------------------------------------------------------------
  print_debug (' ------- +++ [ COMBINING LEFTCOL ] ');
  tableName_name := 'tableName';
  LEFTCOL_name := 'LEFTCOL';
  RIGHTCOL_name := 'RIGHTCOL';
  SEMANTICDEPENDENCY_name := 'SEMANTICDEPENDENCY';
  PERCENTAGE_name := 'PERCENTAGE';
  

  myQuery := 'INSERT INTO '||DR_SemanticDependencies||' SELECT '||tableName_name
  ||',LISTAGG('||LEFTCOL_name||', '' + '') WITHIN GROUP (ORDER BY '||LEFTCOL_name||'), '||SEMANTICDEPENDENCY_name
  ||','||RIGHTCOL_name||',ROUND(AVG('||PERCENTAGE_name||')) FROM   '||DR_SemanticDependencies
  ||' WHERE '||SEMANTICDEPENDENCY_name||' = ''-DF-'' GROUP BY '||
  tableName_name||', '|| RIGHTCOL_name||','|| SEMANTICDEPENDENCY_name;
  print_debug (' ----- [  ');
  print_debug (' -------  '|| myQuery ||' ] ');
  print_debug (' ----- ]  ');
  EXECUTE IMMEDIATE myQuery ;
  print_debug (' ---------- [ select * from '|| DR_SemanticDependencies ||'; ] ');
  print_debug (' +---------------------------------------------------------------------+ ');
END;
/


