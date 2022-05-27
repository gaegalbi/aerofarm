insert
into
    member
(email, nickname, password, phone_number, picture, provider, score, verify)
values
    ('admin@admin.com', 'admin', '$2a$10$VZk/p9U7oYQQqhS4lrv45.Ih.ZRN.Sll5EO9zQ.xWQz3KSqktVzpe', '010-0000-0000', null, 'LOCAL', 10, true);
insert into member_role (member_id, role) values (1, 'GUEST');
insert into member_role (member_id, role) values (1, 'MEMBER');
insert into member_role (member_id, role) values (1, 'ADMIN');

insert into PRODUCT (NAME, PRICE, STOCK, CATEGORY) values ( 'Apple', 1000, 100, 'ETC');
insert into PRODUCT (NAME, PRICE, STOCK, CATEGORY) values ( 'Pear', 1000, 100, 'ETC');
insert into PRODUCT (NAME, PRICE, STOCK, CATEGORY) values ( 'Banana', 1000, 100, 'ETC');