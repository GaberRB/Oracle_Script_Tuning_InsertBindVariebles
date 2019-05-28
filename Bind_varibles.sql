--criar tabela teste
CREATE TABLE PRODUTO_TESTE(
 ID_PRODUTO NUMBER(9),
 NOME_PRODUTO VARCHAR2(30)
 ) ;

--criação da procedure 
CREATE OR REPLACE PROCEDURE PKG_PRODUTO_TESTE AS
  ID_PRODUTO NUMBER(9);
  NOME_PRODUTO VARCHAR2(30);
  start_time PLS_INTEGER :=0;
  stop_time PLS_INTEGER :=0;
  total_time PLS_INTEGER :=0;
BEGIN
  
  start_time := DBMS_UTILITY.GET_TIME;
  FOR i IN 1 .. 10000
  LOOP
    ID_PRODUTO :=0 + i;
    NOME_PRODUTO := 'Produto' || ' - ' || to_char(ID_PRODUTO);
    --utilização bind varibles 
    EXECUTE IMMEDIATE 'INSERT INTO PRODUTO_TESTE VALUES (:ID_PRODUTO, :NOME_PRODUTO)' USING ID_PRODUTO, NOME_PRODUTO;
  END LOOP;
  COMMIT;
  --tempo de execuçao 
  stop_time := DBMS_UTILITY.GET_TIME;
  total_time := (stop_time - start_time) * 10;
  DBMS_OUTPUT.PUT_LINE('Execution time in ms: ' || total_time);
END;

--chamada 
CALL PKG_PRODUTO_TESTE(); -- Execution time in ms: 340
SELECT * FROM  PRODUTO_TESTE ORDER BY 1 ;
DELETE FROM PRODUTO_TESTE;
COMMIT;
