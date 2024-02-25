CREATE TABLE MyHierarchy (
    NodeID NUMBER PRIMARY KEY,
    ParentNodeID NUMBER,
    NodeName VARCHAR2(255)
);
select * from MyHierarchy;
INSERT INTO MyHierarchy (NodeID, ParentNodeID, NodeName)
VALUES (1, NULL, 'Root');
INSERT INTO MyHierarchy (NodeID, ParentNodeID, NodeName)
VALUES (2, 1, 'Child 1');
INSERT INTO MyHierarchy (NodeID, ParentNodeID, NodeName)
VALUES (3, 1, 'Child 2');
INSERT INTO MyHierarchy (NodeID, ParentNodeID, NodeName)
VALUES (4, 2, 'Child 22');
commit;
truncate TABLE MyHierarchy;

SELECT NodeID, ParentNodeID, NodeName, LEVEL 
FROM MyHierarchy
CONNECT BY PRIOR NodeID = ParentNodeID
START WITH ParentNodeID IS NULL;



-- 2. Отображение всех подчиненных узлов с указанием уровня иерархии
CREATE OR REPLACE PROCEDURE DisplayChildNodes(
    ParentID IN NUMBER
) AS
BEGIN
    FOR RecursiveHierarchy IN (
        SELECT NodeID, ParentNodeID, NodeName, LEVEL 
        FROM MyHierarchy
        START WITH NodeID = ParentID
        CONNECT BY NOCYCLE PRIOR NodeID = ParentNodeID
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('NodeID: ' || RecursiveHierarchy.NodeID || ', ParentNodeID: ' || RecursiveHierarchy.ParentNodeID || 
        ', NodeName: ' || RecursiveHierarchy.NodeName || ', HierarchyLevel: ' || RecursiveHierarchy.Level);
    END LOOP;
END;
/


-- output parent node and all of its childs
BEGIN
    DisplayChildNodes(2); 
END;
/


-- 3. 
CREATE OR REPLACE PROCEDURE AddChildNode(
    ParentNodeID IN NUMBER,
    NewNodeID IN NUMBER,
    NewNodeName IN VARCHAR2,
    Result OUT VARCHAR2
) AS
BEGIN
    -- Добавляем подчиненный узел
    INSERT INTO MyHierarchy (NodeID, ParentNodeID, NodeName)
    VALUES (NewNodeID, ParentNodeID, NewNodeName);

    -- Проверяем, был ли успешно добавлен новый узел
    DECLARE
        NodeAdded NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO NodeAdded
        FROM MyHierarchy
        WHERE NodeID = NewNodeID;

        IF NodeAdded = 1 THEN
            Result := 'this row id is free';
        ELSE
            Result := 'already exists';
        END IF;
    END;
END;
/

-- 1 - parentnodeid; 5 - nodeid; child 4 -name; 
DECLARE
    ResultMsg VARCHAR2(100);
BEGIN
    AddChildNode(2, 5, 'Child 23', ResultMsg);
    DBMS_OUTPUT.PUT_LINE(ResultMsg);
END;
/

select * from MyHierarchy


-- 4.
CREATE OR REPLACE PROCEDURE MoveSubtree(p_MovingNodeID IN NUMBER, p_TargetNodeID IN NUMBER) IS
BEGIN
    UPDATE MyHierarchy 
    SET ParentNodeID = p_TargetNodeID 
    WHERE NodeID IN (
        SELECT NodeId
        FROM MyHierarchy
        START WITH NodeId = p_MovingNodeID
        CONNECT BY NOCYCLE PRIOR NodeId = ParentNodeID
    );
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
-- ��� ��� �� 1 - �� 2
BEGIN
    MoveSubtree(1, 2);
END;
/

select * from MyHierarchy