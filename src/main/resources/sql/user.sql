DROP TABLE IF EXISTS user;
CREATE TABLE user (
  id int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  name varchar(32) NOT NULL COMMENT '姓名',
  birthday datetime DEFAULT NULL COMMENT '生日',
  address varchar(128) DEFAULT NULL COMMENT '地址',
  phone varchar(11) DEFAULT NULL COMMENT '电话',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into user(name,birthday,address,phone)
  select '张学友','1968-09-08','中国香港','18989890098' union
  select '张惠妹','1969-01-05','中国北京','13345678781' union
  select '张国立',SYSDATE(),'中国珠海','13567453422';

