set serveroutput on;
-- Sign up
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_USER_PRIMARY('MALE','Sharma','Rohan',5046218927,'rohansharma@gmail.com','23-Jan-1989','I love HP','Cycling','165','Boston','MA','gdghsgwyuab.com','password123','234FD5TF01');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_USER_PRIMARY('FEMALE','Butt','James',8102929388,'buttjames@gmail.com','28-Feb-1999','I am from NYC','3D printing','173','New Orleans','LA','aidygqwf.com','1980290','758FE2IJ02');												
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_USER_PRIMARY('TRANS','Darakjy','Josephine',8566368749,'josephine_darakjy@darakjy.org','01-Nov-1992','Hey how are you','amateur radio','167','Brighton','MI','hgdgqwkf.com','tornadof','300AS2UN03');											
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_USER_PRIMARY('PANGENDER','Venere','Art',9073854412,'art@venere.org','11-Dec-1994','I am from into singing','scrapbook','180','Bridgeport','NJ','qudqwfqff.com','vova87654','196DF3TH04');												
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_USER_PRIMARY('POLYGENDER','Paprocki','Lenna',5135701893,'lpaprocki@hotmail.com','23-Jan-1989','I love ice-cream','Amateur radio','163','Anchorage','AK','wyfqiwvfqf.com','XpKvShrO','786VG2UJ05');												
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_USER_PRIMARY('OTHERS','Foller','Donette',4195032484,'donette.foller@cox.net','28-Feb-1999','Love Indian Food','Acting','165','Hamilton','OH','qiuetif.com','QuieaX','729BN7GC06');												
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_USER_PRIMARY('MALE','Morasca','Simona',7735736914,'simona@morasca.com','01-Nov-1992','I am into metalicca','Baton twirling','172','Ashland','OH','sdgiadj.com','stava1','299MQ8DI07');												
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_USER_PRIMARY('FEMALE','Tollner','Mitsue',4087523500,'mitsue_tollner@yahoo.com','11-Dec-1994','I like baseball','Board games','182','Chicago','IL','uigfjkffqw.com','keannn','289GB9AS08');												
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_USER_PRIMARY('TRANS','Dilliard','Leota',6054142147,'leota@hotmail.com','23-Jan-1989','I love movies','Book restoration','174','San Jose','CA','tyqhqwvff.com','xoPTDK','832SS0UA09');												
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_USER_PRIMARY('PANGENDER','Wieser','Sage',4106558723,'sage_wieser@cox.net','28-Feb-1999','I love music','Cabaret','172','Sioux Falls','SD','jdfwqjhvfqw.com','supagordon','204NA5IL10');

-- Photo insertion
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_PHOTO( 'buttjames@gmail.com' , '1980290' , 'VCB5KM221OM0');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_PHOTO( 'josephine_darakjy@darakjy.org' , 'tornadof' , 'NVJXNH3Z9HYC');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_PHOTO( 'art@venere.org' , 'vova87654' , 'T7E3KT21BVXH');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_PHOTO( 'lpaprocki@hotmail.com' , 'XpKvShrO' , '2XDSW5OGZOLY');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_PHOTO( 'donette.foller@cox.net' , 'QuieaX' , 'G3FDJYMHJAYQ');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_PHOTO( 'simona@morasca.com' , 'stava1' , 'AXJEIQRF248A');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_PHOTO( 'mitsue_tollner@yahoo.com' , 'keannn' , 'WER0QYXJ2ZWW');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_PHOTO( 'leota@hotmail.com' , 'xoPTDK' , '80QLBXBVRZPQ');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_PHOTO( 'sage_wieser@cox.net' , 'supagordon' , 'NNJZ1DH5RXKC');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_PHOTO( 'buttjames@gmail.com' , '1980290' , 'VCB5KM221OM022');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_PHOTO( 'josephine_darakjy@darakjy.org' , 'tornadof' , 'NVJXNH3Z9HYC333');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_PHOTO( 'art@venere.org' , 'vova87654' , 'T7E3KT21BVXH3332');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_PHOTO( 'lpaprocki@hotmail.com' , 'XpKvShrO' , '2XDSW5OGZOLY13323');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_PHOTO( 'donette.foller@cox.net' , 'QuieaX' , 'G3FDJYMHJAYQ31313');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_PHOTO( 'buttjames@gmail.com' , '1980290' , 'VCB5KM221OM0eeww');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_PHOTO( 'josephine_darakjy@darakjy.org' , 'tornadof' , 'NVJXNH3Z9HYeeeqC');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_PHOTO( 'art@venere.org' , 'vova87654' , 'T7E3KT21BeeeVXH');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_PHOTO( 'lpaprocki@hotmail.com' , 'XpKvShrO' , '2XDSW5OGZOnnjLY');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_PHOTO( 'donette.foller@cox.net' , 'QuieaX' , 'G3FDJYMHJAmmnYQ');

-- Gender Pref
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_GENDER_PREFERENCE('rohansharma@gmail.com','password123','MALE');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_GENDER_PREFERENCE('buttjames@gmail.com','1980290','TRANS');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_GENDER_PREFERENCE('josephine_darakjy@darakjy.org','tornadof','FEMALE');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_GENDER_PREFERENCE('art@venere.org','vova87654','POLYGENDER');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_GENDER_PREFERENCE('lpaprocki@hotmail.com','XpKvShrO','PANGENDER');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_GENDER_PREFERENCE('donette.foller@cox.net','QuieaX','MALE');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_GENDER_PREFERENCE('simona@morasca.com','stava1','FEMALE');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_GENDER_PREFERENCE('mitsue_tollner@yahoo.com','keannn','FEMALE');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_GENDER_PREFERENCE('leota@hotmail.com','xoPTDK','FEMALE');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_GENDER_PREFERENCE('sage_wieser@cox.net','supagordon','POLYGENDER');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_GENDER_PREFERENCE('rohansharma@gmail.com','password123','FEMALE');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_GENDER_PREFERENCE('buttjames@gmail.com','1980290','MALE');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_GENDER_PREFERENCE('josephine_darakjy@darakjy.org','tornadof','TRANS');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_GENDER_PREFERENCE('lpaprocki@hotmail.com','XpKvShrO','MALE');

-- Relationship pref
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_RELATIONSHIP_TYPE('rohansharma@gmail.com','password123','CASUAL');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_RELATIONSHIP_TYPE('buttjames@gmail.com','1980290','SERIOUS');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_RELATIONSHIP_TYPE('josephine_darakjy@darakjy.org','tornadof','COMMITTED');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_RELATIONSHIP_TYPE('art@venere.org','vova87654','NSA');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_RELATIONSHIP_TYPE('lpaprocki@hotmail.com','XpKvShrO','NOT SURE');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_RELATIONSHIP_TYPE('donette.foller@cox.net','QuieaX','CASUAL');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_RELATIONSHIP_TYPE('simona@morasca.com','stava1','SERIOUS');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_RELATIONSHIP_TYPE('mitsue_tollner@yahoo.com','keannn','COMMITTED');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_RELATIONSHIP_TYPE('leota@hotmail.com','xoPTDK','NSA');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_RELATIONSHIP_TYPE('sage_wieser@cox.net','supagordon','NOT SURE');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_RELATIONSHIP_TYPE('rohansharma@gmail.com','password123','SERIOUS');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_RELATIONSHIP_TYPE('buttjames@gmail.com','1980290','COMMITTED');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_RELATIONSHIP_TYPE('josephine_darakjy@darakjy.org','tornadof','NSA');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_RELATIONSHIP_TYPE('art@venere.org','vova87654','NOT SURE');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_RELATIONSHIP_TYPE('lpaprocki@hotmail.com','XpKvShrO','CASUAL');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_RELATIONSHIP_TYPE('donette.foller@cox.net','QuieaX','CASUAL');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_RELATIONSHIP_TYPE('simona@morasca.com','stava1','CASUAL');
-- LIKES

EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_LIKE('rohansharma@gmail.com','password123','buttjames@gmail.com')
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_LIKE('buttjames@gmail.com','1980290','rohansharma@gmail.com')
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_LIKE('buttjames@gmail.com','1980290','josephine_darakjy@darakjy.org');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_LIKE('josephine_darakjy@darakjy.org','tornadof','buttjames@gmail.com');
EXEC ADMIN_DATING_APP.USER_VIEW_MODULE.VIEW_OTHER_USERS('josephine_darakjy@darakjy.org','tornadof');

exec admin_dating_app.insert_module.INSERT_RATING('rohansharma@gmail.com','password123','buttjames@gmail.com',10);
exec ADMIN_DATING_APP.INSERT_MODULE.INSERT_LIKE('lpaprocki@hotmail.com','XpKvShrO','art@venere.org');
exec ADMIN_DATING_APP.INSERT_MODULE.INSERT_LIKE('art@venere.org','vova87654','lpaprocki@hotmail.com');

EXEC ADMIN_DATING_APP.insert_module.insert_rating('lpaprocki@hotmail.com','XpKvShrO','art@venere.org',7.2);
EXEC ADMIN_DATING_APP.insert_module.insert_rating('art@venere.org','vova87654','lpaprocki@hotmail.com',9.9);

EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_CONVERSATION('lpaprocki@hotmail.com','XpKvShrO','art@venere.org','whats up');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_CONVERSATION('rohansharma@gmail.com','password123','buttjames@gmail.com','Hey how are you?');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_CONVERSATION('buttjames@gmail.com','1980290','rohansharma@gmail.com','I am in nyc');
EXEC ADMIN_DATING_APP.INSERT_MODULE.INSERT_CONVERSATION('art@venere.org','vova87654','lpaprocki@hotmail.com','Nothing much, just hanging out');
EXEC ADMIN_DATING_APP.VIEW_USER_DETAILS('art@venere.org','vova87654');

-- UPDATE BIO
EXEC ADMIN_DATING_APP.UPDATE_MODULE.UPDATE_BIO('buttjames@gmail.com','1980290','I love dance');
EXEC ADMIN_DATING_APP.VIEW_USER_DETAILS('buttjames@gmail.com','1980290');
-- UPDATE CITY
EXEC ADMIN_DATING_APP.UPDATE_MODULE.UPDATE_CITY('buttjames@gmail.com','1980290','Milwakee');
EXEC ADMIN_DATING_APP.VIEW_USER_DETAILS('buttjames@gmail.com','1980290');
-- UPDATE HEIGHT
EXEC ADMIN_DATING_APP.UPDATE_MODULE.UPDATE_HEIGHT('buttjames@gmail.com','1980290','200');
EXEC ADMIN_DATING_APP.VIEW_USER_DETAILS('buttjames@gmail.com','1980290');
-- UPDATE HOBBY
EXEC ADMIN_DATING_APP.UPDATE_MODULE.UPDATE_HOBBY('buttjames@gmail.com','1980290','Dancing');
EXEC ADMIN_DATING_APP.VIEW_USER_DETAILS('buttjames@gmail.com','1980290');
-- UPDATE MEMBERSHIP TYPE
EXEC ADMIN_DATING_APP.UPDATE_MODULE.UPDATE_MEMBERSHIP_TYPE('buttjames@gmail.com','1980290','PREMIUM');
EXEC ADMIN_DATING_APP.VIEW_USER_DETAILS('buttjames@gmail.com','1980290');
-- UPDATE PASSWORD
EXEC ADMIN_DATING_APP.UPDATE_MODULE.UPDATE_PASSWORD('buttjames@gmail.com','1980290','778981');
EXEC ADMIN_DATING_APP.VIEW_USER_DETAILS('buttjames@gmail.com','1980290');
-- UPDATE STATE
EXEC ADMIN_DATING_APP.UPDATE_MODULE.UPDATE_STATE('buttjames@gmail.com','778981','LA');
EXEC ADMIN_DATING_APP.VIEW_USER_DETAILS('buttjames@gmail.com','778981');

--DELETE RELATIONSHIP PREFERENCE
EXEC ADMIN_DATING_APP.VIEW_PHOTOS('buttjames@gmail.com','778981');
EXEC ADMIN_DATING_APP.DELETE_MODULE.DELETE_PHOTO('buttjames@gmail.com','778981', 'VCB5KM221OM0eeww');
EXEC ADMIN_DATING_APP.VIEW_PHOTOS('buttjames@gmail.com','778981');

--DELETE GENDER PREFERENCE
EXEC ADMIN_DATING_APP.VIEW_GENDER_PREFERENCE('buttjames@gmail.com','778981');
EXEC ADMIN_DATING_APP.DELETE_GENDER_PREFERENCE('buttjames@gmail.com','778981', 'MALE');
EXEC ADMIN_DATING_APP.VIEW_GENDER_PREFERENCE('buttjames@gmail.com','778981');

--DELETE USER
EXEC ADMIN_DATING_APP.DELETE_MODULE.DELETE_USER('buttjames@gmail.com','778981');
EXEC ADMIN_DATING_APP.DELETE_MODULE.DELETE_USER('buttjames@gmail.com','778981');