USE students;
INSERT INTO `students` (`user_id`, `user_sort`, `server_ip`, `email`, `access_key`, `secret_key`, `external_id`, `server_test`, `server_check`) VALUES
('user-test', 'user-test', '127.0.0.1', 'test@local.local', 'xxxx-xxx', 'xxxx-xxx', 'xxxx-xxx', '0', 'timestamp');
COMMIT;