create schema myfarmshopDB;
USE myfarmshopDB;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS cart;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL
);

insert into users(id, username, email, password) values(1, '심조소','sim7178@naver.com','Eggmon123123!@#');

CREATE TABLE items (s
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    price INT NOT NULL,
    image VARCHAR(255), -- 이미지 URL을 저장할 열 추가
    category varchar(50) NOT NULL 
);

-- 아이템 데이터 삽입 시 이미지 URL 포함
INSERT INTO items (name, price, image, category) VALUES ('폴리 적상추, 150g', 1190, 'lettuce1.png','채소');
INSERT INTO items (name, price, image, category) VALUES ('폴리 적상추, 300g', 2380, 'lettuce1.png','채소');
INSERT INTO items (name, price, image, category) VALUES ('폴리 청상추, 200g', 1790, 'lettuce3.jpg','채소');
INSERT INTO items (name, price, image, category) VALUES ('폴리 꽃상추, 2kg', 7500, 'lettuce4.png','채소');
INSERT INTO items (name, price, image, category) VALUES ('폴리 홍고추, 500g', 2300, 'redpepper.png','채소');
INSERT INTO items (name, price, image, category) VALUES ('폴리 풋고추, 500g', 2300, 'greenpepper.png','채소');
INSERT INTO items (name, price, image, category) VALUES ('폴리 사과, 300g', 3000, 'apple.png','과일');
INSERT INTO items (name, price, image, category) VALUES ('폴리 바나나, 210g', 2300, 'banana.png','과일');



CREATE TABLE cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT DEFAULT 1,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (item_id) REFERENCES items(id),
    UNIQUE (user_id, item_id)
);
-- AUTO_INCREMENT 값 재설정
ALTER TABLE cart AUTO_INCREMENT = 1;

select * from users;
select * from items;
select * from cart;