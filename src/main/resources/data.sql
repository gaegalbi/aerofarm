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

insert into member (email, nickname, password, phone_number, picture, provider, score, verify, created_date)
values ('user1@user.com', '가나다', '$2a$10$VZk/p9U7oYQQqhS4lrv45.Ih.ZRN.Sll5EO9zQ.xWQz3KSqktVzpe', '010-0000-0000',
        '/image/default-avatar.png', 'LOCAL', 10, true, '2022-06-25 21:06:24.599072');
insert into member_role (member_id, role)
values (3, 'GUEST');

insert into member (email, nickname, password, phone_number, picture, provider, score, verify, created_date)
values ('user2@user.com', '하야마', '$2a$10$VZk/p9U7oYQQqhS4lrv45.Ih.ZRN.Sll5EO9zQ.xWQz3KSqktVzpe', '010-0000-0000',
        '/image/default-avatar.png', 'LOCAL', 10, true, '2022-06-25 21:06:24.599072');
insert into member_role (member_id, role)
values (4, 'GUEST');

insert into product_detail (contents)
values ('<p>haha</p>');

insert into product (created_date, modified_date, category, contents_id, image_url, name, price, stock, sale_count)
values ('2022-06-25 21:06:24.599072', '2022-06-25 21:06:24.599072', 'DEVICE', 1,
        'https://via.placeholder.com/400x500', 'qqc', 100, 100, 0);



insert into post_detail (id, created_date, modified_date, contents)
values (1, '2022-06-29 11:12:38.752227', '2022-06-29 11:12:38.752227', '자유-일반-내용');

insert into post (id, created_date, modified_date, category, delete_tnf, filter, group_id, title, views, post_detail_id,
                  parent_id, member_id)
values (1, '2022-06-29 11:12:38.752227', '2022-06-29 11:12:38.752227', 'free', false, 'normal', 1, '자유-일반', 1, 1, null,
        1);

insert into post_detail (id, created_date, modified_date, contents)
values (2, '2022-06-29 11:12:38.752227', '2022-06-29 11:12:38.752227', '답글-작성');

insert into post (id, created_date, modified_date, category, delete_tnf, filter, group_id, title, views, post_detail_id,
                  parent_id, member_id)
values (2, '2022-06-29 11:12:38.752227', '2022-06-29 11:12:38.752227', 'free', false, 'normal', 1, 'Re:자유-일반', 1, 2, 1,
        1);


insert into comment (id, created_date, modified_date, content, delete_tnf, group_id, parent_id, post_id, member_id)
values (1, '2022-07-18 15:54:37.055948', '2022-07-18 15:54:37.055948', '이야호', false, 1, null, 1, 3);

insert into comment (id, created_date, modified_date, content, delete_tnf, group_id, parent_id, post_id, member_id)
values (2, '2022-07-18 16:01:17.282558', '2022-07-18 16:01:17.282558', '안녕하세요', false, 1, 1, 1, 4);

insert into comment (id, created_date, modified_date, content, delete_tnf, group_id, parent_id, post_id, member_id)
values (3, '2022-07-18 16:01:51.429622', '2022-07-18 16:01:51.429622', '네, 안녕하세요', false, 1, 2, 1, 1);



insert into device (created_date, modified_date, image_url, ip_address, mac_address, model, nickname, member_id,
                    plant_id, uuid, number)
values ('2022-07-07 09:56:03.868090', '2022-07-07 09:56:03.868090', 'https://via.placeholder.com/150x150', '', NULL,
        'DS_001', 'TEST', 1, NULL, 'bcec74a4-ea3f-4b78-a6ed-40f789643036', 1);
insert into device_status (led_on, fan_on, pump_on, fertilizer, humidity, temperature, device_id)
values (false, false, false, 1, 50, 20, 1);

-- insert into PRODUCT (NAME, PRICE, STOCK, CATEGORY) values ( 'Apple', 1000, 100, 'ETC');
-- insert into PRODUCT (NAME, PRICE, STOCK, CATEGORY) values ( 'Pear', 1000, 100, 'ETC');
-- insert into PRODUCT (NAME, PRICE, STOCK, CATEGORY) values ( 'Banana', 1000, 100, 'ETC');