create table audible_book_data(audio_book_title text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci null,
written_by text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci null,
narrated_by text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci null,
duration time null,
published_date date null,
narrated_in text null,
top_rating int null,
total_num_of_reviews int null,
selling_price double);

insert into audible_book_data(audio_book_title, written_by, narrated_by, duration, published_date,
narrated_in, top_rating, total_num_of_reviews, selling_price)
(select audio_book as audio_book_title, writer as written_by, narrator as narrated_by,
sec_to_time(ifnull(hours,0)*3600+ifnull(minutes,0)*60) as duration, release_date as published_date, `language` as narrated_in,
star_rating as analyze_bookstop_rating, number_of_reviews as total_num_of_reviews, price as selling_price from
audible_cleaned a);

select * from audible_book_data;
