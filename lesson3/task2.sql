USE vk;

CREATE TABLE user_desks (		-- стена пользователя
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	from_user_id BIGINT UNSIGNED NOT NULL,
	txt TEXT NOT NULL,
	media_types_id INT UNSIGNED NULL,
    file_name VARCHAR(245) DEFAULT NULL,
    file_size BIGINT DEFAULT NULL,
    likes BIGINT DEFAULT 0, 
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	INDEX fk_user_desk_from_user_idx (from_user_id),
	CONSTRAINT fk_user_desks_media_types FOREIGN KEY (media_types_id) REFERENCES media_types (id),
	CONSTRAINT fk_user_desks_users FOREIGN KEY (user_id) REFERENCES users (id),
	CONSTRAINT fk_user_desks_from_users FOREIGN KEY (from_user_id) REFERENCES users (id)
);

CREATE TABLE user_desk_comments (		-- комментарии к записям на стене
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	message_id BIGINT UNSIGNED NOT NULL,
	from_user_id BIGINT UNSIGNED NOT NULL,
	txt TEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX fk_user_desks_comment_from_user_idx (from_user_id),
	CONSTRAINT fk_desks_comments FOREIGN KEY (message_id) REFERENCES user_desks (id),
	CONSTRAINT fk_desks_from_users FOREIGN KEY (from_user_id) REFERENCES users (id)
);

CREATE TABLE chats (  -- чат
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(25) NOT NULL,
	description VARCHAR(245) DEFAULT NULL,
	admin_id BIGINT UNSIGNED NOT NULL,
  	INDEX fk_chats_admin_idx (admin_id),
  	CONSTRAINT fk_chats_users FOREIGN KEY (admin_id) REFERENCES users (id)
);

CREATE TABLE chats_users (
  chat_id BIGINT UNSIGNED NOT NULL,
  user_id BIGINT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY (chat_id, user_id),
  INDEX fk_chats_users_chat_idx (chat_id),
  INDEX fk_chats_users_users_idx (user_id),
  CONSTRAINT fk_chats_users_chats FOREIGN KEY (chat_id) REFERENCES chats (id),
  CONSTRAINT fk_chats_users_users FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE chats_messages (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	chat_id BIGINT UNSIGNED NOT NULL,
	from_user_id BIGINT UNSIGNED NOT NULL,
	message TEXT NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX fk_chats_messages_chat_idx (chat_id),
 	INDEX fk_chats_messages_users_idx (from_user_id),
  	CONSTRAINT fk_chats_messages_chats FOREIGN KEY (chat_id) REFERENCES chats (id),
  	CONSTRAINT fk_chats_messages_users FOREIGN KEY (from_user_id) REFERENCES users (id)
)

