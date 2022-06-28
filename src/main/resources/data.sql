insert into member (email, nickname, password, phone_number, picture, provider, score, verify, created_date)
values ('admin@admin.com', 'admin', '$2a$10$VZk/p9U7oYQQqhS4lrv45.Ih.ZRN.Sll5EO9zQ.xWQz3KSqktVzpe', '010-0000-0000',
        '/image/default-avatar.png', 'LOCAL', 10, true, '2022-06-25 21:06:24.599072');
insert into member_role (member_id, role)
values (1, 'GUEST');
insert into member_role (member_id, role)
values (1, 'MEMBER');
insert into member_role (member_id, role)
values (1, 'ADMIN');

insert into member (email, nickname, password, phone_number, picture, provider, score, verify, created_date)
values ('user@user.com', 'user', '$2a$10$VZk/p9U7oYQQqhS4lrv45.Ih.ZRN.Sll5EO9zQ.xWQz3KSqktVzpe', '010-0000-0000',
        '/image/default-avatar.png', 'LOCAL', 10, true, '2022-06-25 21:06:24.599072');
insert into member_role (member_id, role)
values (2, 'GUEST');

insert into product_detail (contents)
values ('<p>haha</p>');

insert into product (created_date, modified_date, category, contents_id, image_url, name, price, stock, sale_count)
values ('2022-06-25 21:06:24.599072', '2022-06-25 21:06:24.599072', 'DEVICE', 1,
        'https://via.placeholder.com/400x500', 'qqc', 100, 100, 0);

-- insert into PRODUCT (NAME, PRICE, STOCK, CATEGORY) values ( 'Apple', 1000, 100, 'ETC');
-- insert into PRODUCT (NAME, PRICE, STOCK, CATEGORY) values ( 'Pear', 1000, 100, 'ETC');
-- insert into PRODUCT (NAME, PRICE, STOCK, CATEGORY) values ( 'Banana', 1000, 100, 'ETC');