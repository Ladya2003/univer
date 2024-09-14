CREATE OR REPLACE PROCEDURE insertequipmentlist(
    insertId in equipmentlist.id%TYPE,
    insertDescription in equipmentlist.description%TYPE
)
IS
BEGIN
    INSERT INTO equipmentlist(id, description)
    VALUES (insertId, insertDescription);
    COMMIT;
END;

EXEC insertequipmentlist(5, '123');

DECLARE 
    i NUMBER := 5;
BEGIN
    WHILE i <= 100000 LOOP
        insertequipmentlist(i, 'description' || i);
        i := i + 1;
    END LOOP;
END;

select * from equipmentlist order by id;
delete from equipmentlist where id = 5;

DECLARE 
    i NUMBER := 5;
BEGIN
    WHILE i <= 10 LOOP
        delete from equipmentlist where id = i;
        i := i + 1;
    END LOOP;
END;
/

?

DECLARE
    t1 number:= dbms_utility.get_time();
begin
    for r in (select * from equipmentlist where id > 50000 and id < 70000) loop null; end loop; 
    dbms_output.put_line('query elapsed: '|| (dbms_utility.get_time()-t1)/100);
end;

select * from equipmentlist where id > 50000 and id < 70000;
create index equipmentlist2 on equipmentlist(id) tablespace ts_user;



CREATE DIRECTORY XML_DIR AS 'E:\Apps\xml';
GRANT READ, WRITE ON DIRECTORY XML_DIR TO ADMINCORE;

CREATE OR REPLACE PROCEDURE XMLExportClient (
  directory_name IN VARCHAR2,
  xmlfile IN VARCHAR2
) AS 
  doc xmldom.DOMDocument;
  ret xmldom.DOMNode;
  peoplenode xmldom.DOMNode;
  Cursor cur_people is select * from client;
  procedure addperson (
    doc xmldom.DOMDocument, 
    client xmldom.DOMNode,
    v_pid varchar2,
    v_name varchar2,
    v_surname varchar2, 
    v_email varchar2,
    v_age varchar2 
  ) is
    personelem xmldom.DOMElement; 
    personnode xmldom.DOMNode; 
    itemelem xmldom.DOMElement; 
    itemnode xmldom.DOMNode; 
    text xmldom.DOMText;
  begin
    personelem:=xmldom.createElement(doc, 'CLIENT');
    xmldom.setAttribute(personelem, 'CLIENTID',v_pid);
    personnode:=xmldom.appendChild(peoplenode,xmldom.makeNode(personelem));
    itemelem:=xmldom.createElement(doc, 'NAME');
    itemnode:=xmldom.appendChild(personnode,xmldom.makeNode(itemelem));
    text:=xmldom.createTextNode(doc,v_name);
    itemnode:=xmldom.appendChild(itemnode,xmldom.makeNode(text));
    itemelem:=xmldom.createElement(doc, 'SURNAME');
    itemnode:=xmldom.appendChild(personnode,xmldom.makeNode(itemelem)); 
    text:=xmldom.createTextNode(doc,v_surname);
    itemnode:=xmldom.appendChild(itemnode,xmldom.makeNode(text)); 
    itemelem:=xmldom.createElement(doc, 'EMAIL');
    itemnode:=xmldom.appendChild(personnode,xmldom.makeNode(itemelem));
    text:=xmldom.createTextNode(doc,v_email);
    itemnode:=xmldom.appendChild(itemnode,xmldom.makeNode(text)); 
    itemelem:=xmldom.createElement(doc, 'AGE');
    itemnode:=xmldom.appendChild(personnode,xmldom.makeNode(itemelem));
    text:=xmldom.createTextNode(doc,v_age);
    itemnode:=xmldom.appendChild(itemnode,xmldom.makeNode(text));
  end addperson;
begin
  doc:=xmldom.newDOMDocument;
  peoplenode:=xmldom.makeNode(xmldom.createElement(doc, 'CLIENTS'));
  ret:=xmldom.appendChild(xmldom.makeNode(doc), peoplenode);
  for v_row in cur_people loop
    addperson(
      doc,
      peoplenode,
      v_row.id,
      v_row.name,
      v_row.surname,
      v_row.email,
      v_row.age
    ); 
  end loop;
  xmldom.writeToFile(doc, directory_name, xmlfile);
  xmldom.freeDocument(doc);
end;


BEGIN
  XMLExportClient('XML_DIR', 'client.xml');
END;

SELECT value FROM nls_database_parameters WHERE parameter = 'NLS_CHARACTERSET';

ALTER TABLE client MODIFY (name VARCHAR2(40) CHARACTER SET UTF8);



--2021
CREATE DIRECTORY XML_DIR AS 'E:\Apps\xml';
?

create or replace procedure ExportEQUIPMENTtoXml
is
DOC DBMS_XMLDOM.DOMDocument;
XDATA XMLTYPE;
CURSOR XMLCUR IS
SELECT XMLELEMENT("EQUIPMENTS",
XMLAttributes
('http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi", 'http://www.oracle.com/Users.xsd' AS "xsi:nonamespaceSchemaLocation"),
XMLAGG (XMLELEMENT("EQUIPMENT",
xmlelement ("id", EQUIPMENT.id),
xmlelement ("transmission", EQUIPMENT.transmission),
xmlelement("salon", EQUIPMENT.salon),
xmlelement("stereo_system", EQUIPMENT.stereo_system)
))) from EQUIPMENT;
begin
open xmlcur;
loop
fetch xmlcur into xdata;
exit when xmlcur%notfound;
end loop;
close xmlcur;
DOC := DBMS_XMLDOM.NewDOMDocument(XDATA);
DBMS_XMLDOM.WRITETOFILE (DOC, 'UTLDATA/EQUIPMENTS.xml');
END;

create or replace procedure ExportClienttoXml
is
DOC DBMS_XMLDOM.DOMDocument;
XDATA XMLTYPE;
CURSOR XMLCUR IS
SELECT XMLELEMENT("CLIENTS",
XMLAttributes
('http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi", 'http://www.oracle.com/Users.xsd' AS "xsi:nonamespaceSchemaLocation"),
XMLAGG (XMLELEMENT("CLIENT",
xmlelement ("id", CLIENT.id),
xmlelement ("name", CLIENT.name),
xmlelement("surname", CLIENT.surname),
xmlelement("age", CLIENT.age),
xmlelement("email", CLIENT.email)
))) from CLIENT;
begin
open xmlcur;
loop
fetch xmlcur into xdata;
exit when xmlcur%notfound;
end loop;
close xmlcur;
DOC := DBMS_XMLDOM.NewDOMDocument(XDATA);
DBMS_XMLDOM.WRITETOFILE(DOC, 'XML_DIR/', 'CLIENTS.xml');
END;


create or replace procedure ExportEQUIPMENTtoXml
is
DOC DBMS_XMLDOM.DOMDocument;
XDATA XMLTYPE;
CURSOR XMLCUR IS
SELECT XMLELEMENT("EQUIPMENTS",
XMLAttributes
('http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi", 'http://www.oracle.com/Users.xsd' AS "xsi:nonamespaceSchemaLocation"),
XMLAGG (XMLELEMENT("EQUIPMENT",
xmlelement ("id", EquipmentList.id),
xmlelement ("description", EquipmentList.description)
))) from EquipmentList;
begin
open xmlcur;
loop
fetch xmlcur into xdata;
exit when xmlcur%notfound;
end loop;
close xmlcur;
DOC := DBMS_XMLDOM.NewDOMDocument(XDATA);
DBMS_XMLDOM.WRITETOFILE (DOC, 'XML_DIR/', 'EQUIPMENTS.xml');
END;

execute ExportEQUIPMENTtoXml;

select * from equipmentlist order by id;
begin 
execute ExportClienttoXml;
end;

ALTER TABLE Client 
MODIFY (
  name VARCHAR2(40) CHARACTER SET UTF8,
  surname VARCHAR2(40) CHARACTER SET UTF8,
  email VARCHAR2(50) CHARACTER SET UTF8
);



--chat

CREATE OR REPLACE PROCEDURE ExportClientToXml
IS
  DOC  DBMS_XMLDOM.DOMDocument;
  XDATA XMLTYPE;
BEGIN
  SELECT XMLELEMENT("CLIENTS",
                    XMLATTRIBUTES('http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi", 
                                   'http://www.oracle.com/Users.xsd' AS "xsi:noNamespaceSchemaLocation"),
                    XMLAGG(XMLELEMENT("CLIENT",
                             xmlelement("id", CLIENT.id),
                             xmlelement("name", CLIENT.name),
                             xmlelement("surname", CLIENT.surname),
                             xmlelement("age", CLIENT.age),
                             xmlelement("email", CLIENT.email)
                             )
                           )
         ) INTO XDATA
  FROM CLIENT;
  DOC := DBMS_XMLDOM.NewDOMDocument(XDATA);
  DBMS_XMLDOM.WRITETOFILE(DOC, 'XML_DIR', 'CLIENTS.xml');
END;
/

EXECUTE ExportClientToXml;







