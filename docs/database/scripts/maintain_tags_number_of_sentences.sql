-- create the trigger

-- on insertion
DROP TRIGGER insert_in_tags ;
delimiter |
CREATE TRIGGER insert_in_tags AFTER INSERT ON tags_sentences
    FOR EACH ROW BEGIN
        UPDATE tags SET nbrOfSentences = nbrOfSentences + 1 WHERE id = NEW.tag_id;
    END;
|

-- delete
DROP TRIGGER remove_tag_from_sentence |
CREATE TRIGGER remove_tag_from_sentence AFTER DELETE ON tags_sentences
    FOR EACH ROW BEGIN
        UPDATE tags SET nbrOfSentences = nbrOfSentences - 1 WHERE id = OLD.tag_id;
    END;
|

-- update 
DROP TRIGGER update_tags_sentences |
CREATE TRIGGER update_tags_sentences AFTER UPDATE ON tags_sentences
    FOR EACH ROW BEGIN
        UPDATE tags SET nbrOfSentences = nbrOfSentences - 1 WHERE id = OLD.tag_id;
        UPDATE tags SET nbrOfSentences = nbrOfSentences + 1 WHERE id = NEW.tag_id;
    END;
|


delimiter ;
