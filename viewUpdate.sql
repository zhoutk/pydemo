-- ----------------------------
-- View structure for v_goods_on_tags_for_group
-- ----------------------------
DROP VIEW IF EXISTS `v_goods_on_tags_for_group`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_goods_on_tags_for_group` AS select `goods_on_tags`.`id` AS `id`,`goods_on_tags`.`goods_id` AS `goods_id`,`goods_on_tags`.`tag_id` AS `tag_id`,`goods_on_tags`.`status` AS `status`,`goods_tag`.`tag_name` AS `tag_name`,`goods_tag`.`tag_group` AS `tag_group`,`goods_tag`.`tag_type` AS `tag_type`,`goods_tag`.`picpath` AS `picpath` from (`goods_on_tags` join `goods_tag` on((`goods_on_tags`.`tag_id` = `goods_tag`.`id`))) ;


-- ----------------------------
-- View structure for v_goods_on_tags_group
-- ----------------------------
DROP VIEW IF EXISTS `v_goods_on_tags_group`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_goods_on_tags_group` AS select `v_goods_on_tags_for_group`.`goods_id` AS `goods_id`,group_concat(`v_goods_on_tags_for_group`.`tag_id`,',',`v_goods_on_tags_for_group`.`tag_name` order by `v_goods_on_tags_for_group`.`tag_id` ASC separator ',') AS `tags`,group_concat(`v_goods_on_tags_for_group`.`tag_id` order by `v_goods_on_tags_for_group`.`tag_id` ASC separator ',') AS `tag_ids`,group_concat(`v_goods_on_tags_for_group`.`tag_name` order by `v_goods_on_tags_for_group`.`tag_name` ASC separator ',') AS `tag_names` from `v_goods_on_tags_for_group` group by `v_goods_on_tags_for_group`.`goods_id` ;

-- ----------------------------
-- View structure for v_address_view
-- ----------------------------
DROP VIEW IF EXISTS `v_address_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_address_view` AS select `address`.`id` AS `id`,`address`.`u_id` AS `u_id`,`address`.`province_id` AS `province_id`,ifnull((select `city_zone`.`name` from `city_zone` where (`city_zone`.`id` = `address`.`province_id`)),'') AS `province_name`,`address`.`city_id` AS `city_id`,ifnull((select `city_zone`.`name` from `city_zone` where (`city_zone`.`id` = `address`.`city_id`)),'') AS `city_name`,`address`.`zone_id` AS `zone_id`,ifnull((select `city_zone`.`name` from `city_zone` where (`city_zone`.`id` = `address`.`zone_id`)),'') AS `zone_name`,`address`.`address` AS `address`,`address`.`recv_name` AS `recv_name`,`address`.`phone` AS `phone`,`address`.`zipcode` AS `zipcode`,`address`.`status` AS `status`,`address`.`is_default` AS `is_default`,`address`.`create_time` AS `create_time`,`address`.`update_time` AS `update_time` from `address` ;

-- ----------------------------
-- View structure for v_advert_acitivity_goods
-- ----------------------------
DROP VIEW IF EXISTS `v_advert_acitivity_goods`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_advert_acitivity_goods` AS select `advert_acitivity_goods`.`id` AS `id`,`advert_acitivity_goods`.`actid` AS `actid`,`advert_acitivity_goods`.`goodsid` AS `goodsid`,`advert_acitivity_goods`.`sequence` AS `sequence`,`advert_acitivity_goods`.`status` AS `status`,`goods`.`name` AS `name`,`goods`.`price` AS `price`,`goods`.`title_pic` AS `title_pic`,`goods`.`activity_json` AS `activity_json`,`goods`.`sale_count` AS `sale_count`,`goods`.`base_sale_count` AS `base_sale_count`,`goods`.`sale_price` AS `sale_price` from (`advert_acitivity_goods` join `goods` on(((`advert_acitivity_goods`.`goodsid` = `goods`.`id`) and (`goods`.`status` = 3)))) ;

-- ----------------------------
-- View structure for v_advert_acitivity_goods_view
-- ----------------------------
DROP VIEW IF EXISTS `v_advert_acitivity_goods_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_advert_acitivity_goods_view` AS select `advert_acitivity_goods`.`actid` AS `actid`,`goods`.`id` AS `id`,`goods`.`name` AS `name`,`goods`.`title_pic` AS `title_pic`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price` from (`advert_acitivity_goods` join `goods` on((`advert_acitivity_goods`.`goodsid` = `goods`.`id`))) ;

-- ----------------------------
-- View structure for v_best_choice_group
-- ----------------------------
DROP VIEW IF EXISTS `v_best_choice_group`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_best_choice_group` AS select `best_choice`.`group_id` AS `group_id`,max(`best_choice`.`create_time`) AS `create_time`,`best_choice`.`status` AS `status` from `best_choice` group by `best_choice`.`group_id` order by `create_time` desc ;

-- ----------------------------
-- View structure for v_city
-- ----------------------------
DROP VIEW IF EXISTS `v_city`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_city` AS select `address`.`id` AS `id`,`address`.`address` AS `address`,`address`.`recv_name` AS `recv_name`,`address`.`phone` AS `phone`,`address`.`status` AS `status`,`address`.`is_default` AS `is_default`,`address`.`create_time` AS `create_time`,`address`.`update_time` AS `update_time`,`city_zone`.`id` AS `city_zone` from (`city_zone` join `address` on((`city_zone`.`id` = `address`.`zone_id`))) ;

-- ----------------------------
-- View structure for v_colum_info
-- ----------------------------
DROP VIEW IF EXISTS `v_colum_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_colum_info` AS select `colum_category`.`name` AS `category_name`,`colum_info`.`id` AS `id`,`colum_info`.`category` AS `category`,`colum_info`.`colum_title` AS `colum_title`,`colum_info`.`colum_type` AS `colum_type`,`colum_info`.`picpath` AS `picpath`,`colum_info`.`urlpath` AS `urlpath`,`colum_info`.`create_time` AS `create_time`,`colum_info`.`order_code` AS `order_code` from (`colum_info` join `colum_category` on((`colum_info`.`category` = `colum_category`.`id`))) ;

-- ----------------------------
-- View structure for v_company
-- ----------------------------
DROP VIEW IF EXISTS `v_company`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_company` AS select `company`.`id` AS `id`,`company`.`pid` AS `pid`,`company`.`name` AS `name`,`company`.`province_id` AS `province_id`,`company`.`type` AS `type`,`company`.`city_id` AS `city_id`,`company`.`company_name` AS `company_name`,`company`.`remark` AS `remark`,`company`.`create_time` AS `create_time`,`company`.`update_time` AS `update_time`,`c_zone`.`name` AS `city_name`,`p_zone`.`name` AS `province_name`,`company`.`start_time` AS `start_time`,`company`.`end_time` AS `end_time` from ((`company` join `city_zone` `p_zone` on((`company`.`province_id` = `p_zone`.`id`))) join `city_zone` `c_zone` on((`company`.`city_id` = `c_zone`.`id`))) ;

-- ----------------------------
-- View structure for v_fans_order_goods
-- ----------------------------
DROP VIEW IF EXISTS `v_fans_order_goods`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_fans_order_goods` AS select `order_item`.`goodsid` AS `goodsid`,`order_item`.`status` AS `status`,`order_item`.`u_id` AS `u_id`,`order_item`.`main_order_id` AS `main_order_id` from `order_item` group by `order_item`.`goodsid`,`order_item`.`u_id` ;

-- ----------------------------
-- View structure for v_fans_order_goods_view
-- ----------------------------
DROP VIEW IF EXISTS `v_fans_order_goods_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_fans_order_goods_view` AS select `oi`.`goodsid` AS `id`,`om`.`u_id` AS `u_id`,`gd`.`name` AS `name`,`gd`.`price` AS `price`,`gd`.`title_pic` AS `title_pic`,`oi`.`status` AS `status` from ((`order_main` `om` join `v_fans_order_goods` `oi` on((`om`.`id` = `oi`.`main_order_id`))) join `goods` `gd` on((`oi`.`goodsid` = `gd`.`id`))) where ((`om`.`consumption_category` <> 3) and (`om`.`consumption_category` <> 5)) ;

-- ----------------------------
-- View structure for v_fans_sign_record_list
-- ----------------------------
DROP VIEW IF EXISTS `v_fans_sign_record_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_fans_sign_record_list` AS select `fans_sign_record`.`id` AS `id`,`fans_sign_record`.`sign_cfg_id` AS `sign_cfg_id`,`fans_sign_record`.`fans_id` AS `fans_id`,`fans_sign_record`.`create_time` AS `create_time`,`fans_sign_record`.`sign_index` AS `sign_index`,`fans_sign_record`.`curr_get_points` AS `curr_get_points`,`fans_sign_record`.`status` AS `status`,`sign_config`.`name` AS `cfg_name`,`member`.`nickname` AS `nickname`,`member`.`username` AS `username` from ((`fans_sign_record` join `member` on((`fans_sign_record`.`fans_id` = `member`.`id`))) join `sign_config` on((`fans_sign_record`.`sign_cfg_id` = `sign_config`.`id`))) ;

-- ----------------------------
-- View structure for v_fans_ticket
-- ----------------------------
DROP VIEW IF EXISTS `v_fans_ticket`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_fans_ticket` AS select `fans_ticket`.`id` AS `id`,`fans_ticket`.`fansid` AS `u_id`,`fans_ticket`.`ticketid` AS `ticketid`,`fans_ticket`.`get_time` AS `get_time`,`fans_ticket`.`use_time` AS `use_time`,`fans_ticket`.`end_time` AS `end_time`,`ticket`.`type` AS `type`,`ticket`.`name` AS `name`,`ticket`.`full_price` AS `full_price`,`ticket`.`price` AS `price`,`ticket`.`picurl` AS `picurl`,`ticket`.`remark` AS `remark`,`ticket`.`can_use` AS `can_use`,`ticket`.`effect_hour` AS `effect_hour`,`ticket`.`goods_class_json` AS `goods_class_json`,(case when (now() > `fans_ticket`.`end_time`) then 2 else `fans_ticket`.`status` end) AS `status` from (`ticket` join `fans_ticket` on((`ticket`.`id` = `fans_ticket`.`ticketid`))) ;

-- ----------------------------
-- View structure for v_fans_tryout_goods_view
-- ----------------------------
DROP VIEW IF EXISTS `v_fans_tryout_goods_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_fans_tryout_goods_view` AS select distinct `goods`.`id` AS `id`,`goods`.`category` AS `goods_category`,`tryout_apply`.`fansid` AS `fansid`,`goods`.`name` AS `name`,`goods`.`title_pic` AS `title_pic`,`goods`.`price` AS `price`,`tryout`.`id` AS `tryoutid`,`tryout_apply`.`status` AS `tryapp_status` from ((`tryout_apply` join `tryout` on((`tryout_apply`.`tryoutid` = `tryout`.`id`))) join `goods` on((`tryout`.`goodsid` = `goods`.`id`))) ;

-- ----------------------------
-- View structure for v_get_my_points
-- ----------------------------
DROP VIEW IF EXISTS `v_get_my_points`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_get_my_points` AS select `member`.`id` AS `id`,`member`.`points` AS `points` from `member` ;

-- ----------------------------
-- View structure for v_gift_card
-- ----------------------------
DROP VIEW IF EXISTS `v_gift_card`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_gift_card` AS select `gift_card`.`id` AS `id`,`gift_card`.`flag` AS `flag`,`gift_card`.`batch` AS `batch`,`gift_card`.`card_number` AS `card_number`,`gift_card`.`show_number` AS `show_number`,`gift_card`.`password` AS `password`,`gift_card`.`open_price` AS `open_price`,`gift_card`.`remaining_price` AS `remaining_price`,`gift_card`.`activate_time` AS `activate_time`,`gift_card`.`bind_time` AS `bind_time`,`gift_card`.`end_time` AS `end_time`,`gift_card`.`u_id` AS `u_id`,`member`.`nickname` AS `nickname`,`gift_card`.`islock` AS `islock`,(case when (`gift_card`.`remaining_price` <= 0) then 3 when (`gift_card`.`end_time` < now()) then 4 else `gift_card`.`status` end) AS `status` from (`gift_card` left join `member` on((`gift_card`.`u_id` = `member`.`id`))) ;

-- ----------------------------
-- View structure for v_gift_card_use_gift_card
-- ----------------------------
DROP VIEW IF EXISTS `v_gift_card_use_gift_card`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_gift_card_use_gift_card` AS select `gift_card_use_record`.`id` AS `id`,`gift_card_use_record`.`order_main_id` AS `order_main_id`,`gift_card_use_record`.`gift_card_id` AS `gift_card_id`,`gift_card_use_record`.`u_id` AS `u_id`,`gift_card_use_record`.`price` AS `price`,`gift_card_use_record`.`category` AS `category`,`gift_card_use_record`.`effect` AS `effect`,`gift_card_use_record`.`create_time` AS `create_time`,`gift_card`.`card_number` AS `card_number` from (`gift_card_use_record` join `gift_card` on((`gift_card_use_record`.`gift_card_id` = `gift_card`.`id`))) ;

-- ----------------------------
-- View structure for v_gift_card_use_record
-- ----------------------------
DROP VIEW IF EXISTS `v_gift_card_use_record`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_gift_card_use_record` AS select `gift_card`.`card_number` AS `card_number`,`gift_card_use_record`.`id` AS `id`,`gift_card_use_record`.`order_main_id` AS `order_main_id`,`gift_card_use_record`.`u_id` AS `u_id`,`gift_card_use_record`.`price` AS `price`,`gift_card_use_record`.`category` AS `category`,`gift_card_use_record`.`effect` AS `effect`,`gift_card_use_record`.`create_time` AS `create_time`,`gift_card`.`open_price` AS `open_price`,`member`.`nickname` AS `nickname`,`gift_card`.`remaining_price` AS `remaining_price`,`order_main`.`total_price` AS `total_price`,`order_main`.`order_number` AS `order_number`,`member`.`username` AS `username`,`gift_card_use_record`.`fire_remaining_price` AS `fire_remaining_price` from (((`gift_card` join `gift_card_use_record` on((`gift_card`.`id` = `gift_card_use_record`.`gift_card_id`))) join `member` on((`member`.`id` = `gift_card_use_record`.`u_id`))) left join `order_main` on((`gift_card_use_record`.`order_main_id` = `order_main`.`id`))) where (`gift_card_use_record`.`effect` = 1) ;

-- ----------------------------
-- View structure for v_goods_category_1
-- ----------------------------
DROP VIEW IF EXISTS `v_goods_category_1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_goods_category_1` AS select `goods_category`.`id` AS `id`,`goods_category`.`name` AS `name`,`goods_category`.`remark` AS `remark`,`goods_category`.`goods_type` AS `goods_type`,`goods_category`.`status` AS `status`,`goods_category`.`pid` AS `pid`,`goods_category`.`adv_pic` AS `adv_pic`,`goods_category`.`adv_title` AS `adv_title` from `goods_category` where (`goods_category`.`pid` = 0) ;

-- ----------------------------
-- View structure for v_goods_category_2
-- ----------------------------
DROP VIEW IF EXISTS `v_goods_category_2`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_goods_category_2` AS select `goods_category`.`id` AS `id`,`goods_category`.`name` AS `name`,`goods_category`.`remark` AS `remark`,`goods_category`.`goods_type` AS `goods_type`,`goods_category`.`status` AS `status`,`goods_category`.`pid` AS `pid`,`goods_category`.`adv_pic` AS `adv_pic`,`goods_category`.`adv_title` AS `adv_title` from (`v_goods_category_1` join `goods_category` on((`goods_category`.`pid` = `v_goods_category_1`.`id`))) ;

-- ----------------------------
-- View structure for v_goods_category_3
-- ----------------------------
DROP VIEW IF EXISTS `v_goods_category_3`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_goods_category_3` AS select `goods_category`.`id` AS `id`,`goods_category`.`name` AS `name`,`goods_category`.`remark` AS `remark`,`goods_category`.`goods_type` AS `goods_type`,`goods_category`.`status` AS `status`,`goods_category`.`pid` AS `pid`,`goods_category`.`adv_pic` AS `adv_pic`,`goods_category`.`adv_title` AS `adv_title` from (`goods_category` join `v_goods_category_2` on((`goods_category`.`pid` = `v_goods_category_2`.`id`))) ;
-- ----------------------------
-- View structure for v_goods_category
-- ----------------------------
DROP VIEW IF EXISTS `v_goods_category`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_goods_category` AS select `v_goods_category_3`.`id` AS `id3`,`v_goods_category_3`.`name` AS `name3`,`v_goods_category_2`.`id` AS `id2`,`v_goods_category_2`.`name` AS `name2`,`v_goods_category_1`.`id` AS `id1`,`v_goods_category_1`.`name` AS `name1`,`v_goods_category_2`.`adv_pic` AS `adv_pic`,`v_goods_category_2`.`adv_title` AS `adv_title` from ((`v_goods_category_3` join `v_goods_category_2` on((`v_goods_category_3`.`pid` = `v_goods_category_2`.`id`))) join `v_goods_category_1` on((`v_goods_category_2`.`pid` = `v_goods_category_1`.`id`))) order by `v_goods_category_1`.`id`,`v_goods_category_2`.`id` ;

-- ----------------------------
-- View structure for v_goods_export
-- ----------------------------
DROP VIEW IF EXISTS `v_goods_export`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_goods_export` AS select `goods`.`id` AS `id`,`goods`.`name` AS `name`,`goods`.`code` AS `code`,`goods`.`comp_id` AS `comp_id`,`goods`.`title_pic` AS `title_pic`,`goods`.`banner_json` AS `banner_json`,`goods`.`details_json` AS `details_json`,`goods`.`brand` AS `brand`,`goods`.`category` AS `category`,`goods`.`start_time` AS `start_time`,`goods`.`end_time` AS `end_time`,`goods`.`speci_json` AS `speci_json`,`goods`.`amount` AS `amount`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price`,`goods`.`delivery` AS `delivery`,`goods`.`send_hour` AS `send_hour`,`goods`.`safeguard_json` AS `safeguard_json`,`goods`.`activity_json` AS `activity_json`,`goods`.`hot_sell` AS `hot_sell`,`goods`.`less_stock` AS `less_stock`,`goods`.`trade_send` AS `trade_send`,`goods`.`status` AS `status`,`goods`.`sale_count` AS `sale_count`,`goods`.`base_sale_count` AS `base_sale_count`,`goods`.`report_count` AS `report_count`,`goods`.`collection_count` AS `collection_count`,`goods`.`remind_count` AS `remind_count`,`goods`.`view_count` AS `view_count`,`goods`.`u_id` AS `u_id`,`goods`.`create_time` AS `create_time`,`goods`.`update_time` AS `update_time`,`goods`.`base_collection_count` AS `base_collection_count`,`goods`.`gid` AS `gid`,`goods`.`auto_inc_id` AS `auto_inc_id`,`goods`.`sequence` AS `sequence`,`v_goods_category`.`name3` AS `name3`,`v_goods_category`.`id2` AS `id2`,`v_goods_category`.`name2` AS `name2`,`v_goods_category`.`id1` AS `id1`,`v_goods_category`.`name1` AS `name1`,`v_goods_category`.`id3` AS `id3`,`goods_brand`.`name` AS `b_name`,`company`.`name` AS `c_name` from (((`goods` join `v_goods_category` on((`goods`.`category` = `v_goods_category`.`id3`))) join `goods_brand` on((`goods`.`brand` = `goods_brand`.`id`))) join `company` on((`goods`.`comp_id` = `company`.`id`))) where (`goods`.`create_time` >= '2017-08-16') ;

-- ----------------------------
-- View structure for v_goods_for_tryout_report_view
-- ----------------------------
DROP VIEW IF EXISTS `v_goods_for_tryout_report_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_goods_for_tryout_report_view` AS select `goods`.`id` AS `id`,`goods`.`name` AS `name`,`goods`.`title_pic` AS `title_pic`,`goods`.`price` AS `price` from `goods` ;

-- ----------------------------
-- View structure for v_goods_group_remind
-- ----------------------------
DROP VIEW IF EXISTS `v_goods_group_remind`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_goods_group_remind` AS select `goods_activity_remind`.`id` AS `id`,`goods_activity_remind`.`u_id` AS `u_id`,`goods_activity_remind`.`goodsid` AS `goodsid`,`goods_activity_remind`.`create_time` AS `create_time`,`goods_activity_remind`.`remind_count` AS `remind_count`,`goods_activity_remind`.`status` AS `status`,`group_buy`.`name` AS `name`,`group_buy`.`start_time` AS `g_start_time`,`member`.`username` AS `username` from ((`goods_activity_remind` join `group_buy` on(((`goods_activity_remind`.`goodsid` = `group_buy`.`goodsid`) and (`group_buy`.`status` = 3)))) join `member` on((`goods_activity_remind`.`u_id` = `member`.`id`))) ;

-- ----------------------------
-- View structure for v_goods_list
-- ----------------------------
DROP VIEW IF EXISTS `v_goods_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_goods_list` AS select `goods`.`id` AS `id`,`goods`.`name` AS `name`,`goods`.`code` AS `code`,`goods`.`title_pic` AS `title_pic`,`goods`.`banner_json` AS `banner_json`,`goods`.`details_json` AS `details_json`,`goods_brand`.`name` AS `brand_name`,`goods`.`start_time` AS `start_time`,`goods`.`end_time` AS `end_time`,`goods`.`speci_json` AS `speci_json`,`goods`.`amount` AS `amount`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price`,`logistics`.`name` AS `delivery_name`,`goods`.`send_hour` AS `send_hour`,`goods`.`safeguard_json` AS `safeguard_json`,`goods`.`activity_json` AS `activity_json`,`goods`.`status` AS `status`,`goods`.`create_time` AS `create_time`,`goods`.`update_time` AS `update_time`,`company`.`name` AS `company_name`,`goods_brand`.`id` AS `brand_id`,`logistics`.`id` AS `delivery_id`,`v_goods_category`.`id3` AS `category3`,`v_goods_category`.`name3` AS `category_name3`,`v_goods_category`.`id2` AS `category2`,`v_goods_category`.`name2` AS `category_name2`,`v_goods_category`.`id1` AS `category1`,`v_goods_category`.`name1` AS `categroy_name1`,`goods`.`category` AS `category`,`goods`.`comp_id` AS `comp_id`,`goods`.`sale_count` AS `goods_sale_count`,`goods`.`collection_count` AS `collection_count`,`goods`.`report_count` AS `report_count`,`goods`.`trade_send` AS `trade_send`,`goods`.`hot_sell` AS `hot_sell`,`goods`.`base_sale_count` AS `goods_base_sale_count`,`goods`.`less_stock` AS `less_stock`,`goods`.`base_collection_count` AS `base_collection_count`,`goods`.`sequence` AS `sequence`,`v_goods_on_tags_group`.`tags` AS `tags`,`v_goods_on_tags_group`.`tag_ids` AS `tag_ids`,`v_goods_on_tags_group`.`tag_names` AS `tag_names`,(case `goods`.`status` when 4 then 4 when 99 then 99 else 0 end) AS `st` from (((((`goods` left join `goods_brand` on(((`goods`.`brand` = `goods_brand`.`id`) and (`goods`.`status` < 99)))) left join `company` on((`goods`.`comp_id` = `company`.`id`))) left join `v_goods_category` on((`goods`.`category` = `v_goods_category`.`id3`))) left join `logistics` on((`goods`.`delivery` = `logistics`.`id`))) left join `v_goods_on_tags_group` on((`goods`.`id` = `v_goods_on_tags_group`.`goods_id`))) ;

-- ----------------------------
-- View structure for v_goods_model_value
-- ----------------------------
DROP VIEW IF EXISTS `v_goods_model_value`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_goods_model_value` AS select `goods_model`.`id` AS `id`,`goods_model`.`name` AS `name`,`goods_model_value`.`name` AS `value`,`goods_model_value`.`status` AS `status`,`goods_model_value`.`id` AS `valueid` from (`goods_model` join `goods_model_value` on((`goods_model`.`id` = `goods_model_value`.`model_id`))) ;

-- ----------------------------
-- View structure for v_goods_net
-- ----------------------------
DROP VIEW IF EXISTS `v_goods_net`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_goods_net` AS select `goods`.`id` AS `id`,`goods`.`name` AS `name`,`goods`.`comp_id` AS `comp_id`,`goods`.`title_pic` AS `title_pic`,`goods`.`banner_json` AS `banner_json`,`goods`.`details_json` AS `details_json`,`goods`.`brand` AS `brand`,`goods`.`category` AS `category`,`goods`.`start_time` AS `start_time`,`goods`.`end_time` AS `end_time`,`goods`.`speci_json` AS `speci_json`,`goods`.`amount` AS `amount`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price`,`goods`.`delivery` AS `delivery`,`goods`.`send_hour` AS `send_hour`,`goods`.`safeguard_json` AS `safeguard_json`,`goods`.`activity_json` AS `activity_json`,`goods`.`hot_sell` AS `hot_sell`,`goods`.`less_stock` AS `less_stock`,`goods`.`trade_send` AS `trade_send`,`goods`.`status` AS `status`,`goods`.`create_time` AS `create_time`,`goods`.`update_time` AS `update_time`,`goods`.`sale_count` AS `sale_count`,`goods`.`report_count` AS `report_count`,`goods`.`collection_count` AS `collection_count`,`goods`.`remind_count` AS `remind_count`,`goods`.`view_count` AS `view_count` from `goods` where ((`goods`.`status` = 3) and isnull(`goods`.`activity_json`) and (not(`goods`.`id` in (select `points_mall_goods`.`ticket_id` from `points_mall_goods` where ((`points_mall_goods`.`category` = 2) and (`points_mall_goods`.`status` = 3)))))) ;

-- ----------------------------
-- View structure for v_goods_net_tryout
-- ----------------------------
DROP VIEW IF EXISTS `v_goods_net_tryout`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_goods_net_tryout` AS select `goods`.`id` AS `id`,`goods`.`name` AS `name`,`goods`.`comp_id` AS `comp_id`,`goods`.`title_pic` AS `title_pic`,`goods`.`banner_json` AS `banner_json`,`goods`.`details_json` AS `details_json`,`goods`.`brand` AS `brand`,`goods`.`category` AS `category`,`goods`.`start_time` AS `start_time`,`goods`.`end_time` AS `end_time`,`goods`.`speci_json` AS `speci_json`,`goods`.`amount` AS `amount`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price`,`goods`.`delivery` AS `delivery`,`goods`.`send_hour` AS `send_hour`,`goods`.`safeguard_json` AS `safeguard_json`,`goods`.`activity_json` AS `activity_json`,`goods`.`hot_sell` AS `hot_sell`,`goods`.`less_stock` AS `less_stock`,`goods`.`trade_send` AS `trade_send`,`goods`.`status` AS `status`,`goods`.`create_time` AS `create_time`,`goods`.`update_time` AS `update_time`,`goods`.`sale_count` AS `sale_count`,`goods`.`report_count` AS `report_count`,`goods`.`collection_count` AS `collection_count`,`goods`.`remind_count` AS `remind_count`,`goods`.`view_count` AS `view_count` from `goods` where ((`goods`.`status` = 3) and (not(`goods`.`id` in (select `tryout`.`goodsid` from `tryout` where (`tryout`.`status` = 3))))) ;

-- ----------------------------
-- View structure for v_goods_on_tags
-- ----------------------------
DROP VIEW IF EXISTS `v_goods_on_tags`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_goods_on_tags` AS select `goods_on_tags`.`id` AS `id`,`goods_on_tags`.`goods_id` AS `goods_id`,`goods_on_tags`.`tag_id` AS `tag_id`,`goods_on_tags`.`status` AS `status`,`goods_tag`.`tag_name` AS `tag_name`,`goods_tag`.`tag_group` AS `tag_group`,`goods_tag`.`tag_type` AS `tag_type`,`goods_tag`.`picpath` AS `picpath`,`v_goods_on_tags_group`.`tag_ids` AS `tag_ids`,`v_goods_on_tags_group`.`tag_names` AS `tag_names` from ((`goods_on_tags` join `goods_tag` on((`goods_on_tags`.`tag_id` = `goods_tag`.`id`))) join `v_goods_on_tags_group` on((`goods_on_tags`.`goods_id` = `v_goods_on_tags_group`.`goods_id`))) ;


-- ----------------------------
-- View structure for v_goods_tag_category
-- ----------------------------
DROP VIEW IF EXISTS `v_goods_tag_category`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_goods_tag_category` AS select `goods_tag`.`id` AS `id`,`goods_tag`.`tag_name` AS `tag_name`,`goods_tag`.`tag_group` AS `tag_group`,`goods_tag`.`tag_type` AS `tag_type`,`goods_tag`.`picpath` AS `picpath`,`goods_tag`.`create_time` AS `create_time`,`goods_category`.`name` AS `category_name`,`goods_category`.`id` AS `category_id`,`goods_category`.`adv_pic` AS `adv_pic`,`goods_category`.`adv_title` AS `adv_title`,`goods_tag`.`order_code` AS `order_code` from (`goods_tag` join `goods_category` on((`goods_tag`.`tag_type` = `goods_category`.`id`))) ;

-- ----------------------------
-- View structure for v_grab_buy
-- ----------------------------
DROP VIEW IF EXISTS `v_grab_buy`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_grab_buy` AS select `grab_buy`.`id` AS `id`,`grab_buy`.`batch_number` AS `batch_number`,`grab_buy`.`sale_price` AS `sale_price`,`grab_buy`.`amount` AS `amount`,`grab_buy`.`small_price` AS `small_price`,`grab_buy`.`goodsid` AS `goodsid`,`grab_buy`.`speci_json` AS `speci_json`,`grab_buy`.`start_time` AS `start_time`,`grab_buy`.`end_time` AS `end_time`,`grab_buy`.`status` AS `status`,`grab_buy`.`sequence` AS `sequence`,`grab_buy`.`sale_count` AS `sale_count`,`grab_buy`.`base_sale_count` AS `base_sale_count`,`grab_buy`.`create_time` AS `create_time`,`grab_buy`.`update_time` AS `update_time`,`grab_buy`.`title_pic` AS `title_pic`,`goods`.`status` AS `gstatus`,`goods`.`price` AS `price`,`goods`.`name` AS `goodsname`,`grab_buy`.`name` AS `name`,`goods`.`comp_id` AS `comp_id`,(case `grab_buy`.`status` when 4 then 4 when 99 then 99 else 0 end) AS `st` from (`grab_buy` join `goods` on((`grab_buy`.`goodsid` = `goods`.`id`))) ;

-- ----------------------------
-- View structure for v_group_buy_for_talent
-- ----------------------------
DROP VIEW IF EXISTS `v_group_buy_for_talent`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_group_buy_for_talent` AS select `group_buy`.`id` AS `id`,`group_buy`.`picpath` AS `picpath`,`group_buy`.`remark` AS `remark`,`group_buy`.`category` AS `category`,`group_buy`.`start_time` AS `start_time`,`group_buy`.`end_time` AS `end_time`,`group_buy`.`goodsid` AS `goodsid`,`group_buy`.`speci_json` AS `speci_json`,`group_buy`.`sale_price` AS `sale_price`,`group_buy`.`small_price` AS `small_price`,`group_buy`.`amount` AS `amount`,`group_buy`.`sale_count` AS `sale_count`,`group_buy`.`base_sale_count` AS `base_sale_count`,`group_buy`.`sequence` AS `sequence`,`group_buy`.`brokerage_type` AS `brokerage_type`,`group_buy`.`brokerage_price` AS `brokerage_price`,`group_buy`.`status` AS `status`,`group_buy`.`create_time` AS `create_time`,`group_buy`.`update_time` AS `update_time`,`goods`.`name` AS `name` from (`group_buy` join `goods` on((`group_buy`.`goodsid` = `goods`.`id`))) where (`group_buy`.`category` = 1) ;

-- ----------------------------
-- View structure for v_group_buy_goods_commit
-- ----------------------------
DROP VIEW IF EXISTS `v_group_buy_goods_commit`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_group_buy_goods_commit` AS select `group_buy_goods_commit`.`id` AS `id`,`group_buy_goods_commit`.`u_id` AS `u_id`,`group_buy_goods_commit`.`goods_name` AS `goods_name`,`group_buy_goods_commit`.`taobao_link` AS `taobao_link`,`group_buy_goods_commit`.`pic_json` AS `pic_json`,`group_buy_goods_commit`.`min_price` AS `min_price`,`group_buy_goods_commit`.`max_price` AS `max_price`,`group_buy_goods_commit`.`sale_count` AS `sale_count`,`group_buy_goods_commit`.`create_time` AS `create_time`,`member`.`nickname` AS `nickname` from (`group_buy_goods_commit` join `member` on((`group_buy_goods_commit`.`u_id` = `member`.`id`))) ;

-- ----------------------------
-- View structure for v_group_buy_list
-- ----------------------------
DROP VIEW IF EXISTS `v_group_buy_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_group_buy_list` AS select `group_buy`.`id` AS `id`,`group_buy`.`picpath` AS `picpath`,`group_buy`.`name` AS `name`,`group_buy`.`remark` AS `remark`,`group_buy`.`category` AS `category`,`group_buy`.`start_time` AS `start_time`,`group_buy`.`end_time` AS `end_time`,`group_buy`.`goodsid` AS `goodsid`,`group_buy`.`speci_json` AS `speci_json`,`group_buy`.`sale_price` AS `sale_price`,`group_buy`.`small_price` AS `small_price`,`group_buy`.`sale_count` AS `sale_count`,`group_buy`.`amount` AS `amount`,`group_buy`.`base_sale_count` AS `base_sale_count`,`group_buy`.`sequence` AS `sequence`,`group_buy`.`brokerage_type` AS `brokerage_type`,`group_buy`.`brokerage_price` AS `brokerage_price`,`group_buy`.`status` AS `status`,`group_buy`.`create_time` AS `create_time`,`group_buy`.`update_time` AS `update_time`,`goods`.`name` AS `goodsname`,`goods`.`status` AS `gstatus`,`goods`.`comp_id` AS `comp_id`,(case `group_buy`.`status` when 4 then 4 when 99 then 99 else 0 end) AS `st` from (`group_buy` join `goods` on((`group_buy`.`goodsid` = `goods`.`id`))) ;

-- ----------------------------
-- View structure for v_group_buy_topic
-- ----------------------------
DROP VIEW IF EXISTS `v_group_buy_topic`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_group_buy_topic` AS select `group_buy_topic_goods`.`id` AS `id`,`group_buy_topic_goods`.`goods_id` AS `goods_id`,`group_buy_topic_goods`.`topic_id` AS `topic_id`,`goods`.`title_pic` AS `title_pic`,`goods`.`status` AS `status`,`goods`.`name` AS `name`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price`,`goods`.`sale_count` AS `sale_count`,`goods`.`base_sale_count` AS `base_sale_count`,`group_buy_topic_goods`.`u_id` AS `u_id`,`member`.`nickname` AS `nickname`,`member`.`picpath` AS `picpath`,`member`.`level` AS `level`,`goods`.`activity_json` AS `activity_json`,`member`.`feeling` AS `feeling` from ((`group_buy_topic_goods` join `goods` on((`group_buy_topic_goods`.`goods_id` = `goods`.`id`))) join `member` on((`group_buy_topic_goods`.`u_id` = `member`.`id`))) where (`goods`.`status` = 3) ;

-- ----------------------------
-- View structure for v_group_buy_topic_goods
-- ----------------------------
DROP VIEW IF EXISTS `v_group_buy_topic_goods`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_group_buy_topic_goods` AS select `group_buy_topic_goods`.`id` AS `id`,`group_buy_topic_goods`.`goods_id` AS `goods_id`,`group_buy_topic_goods`.`group_buy_id` AS `group_buy_id`,`group_buy_topic_goods`.`topic_id` AS `topic_id`,`goods`.`title_pic` AS `title_pic`,`group_buy`.`start_time` AS `start_time`,`group_buy`.`end_time` AS `end_time`,`goods`.`status` AS `status`,`goods`.`activity_json` AS `activity_json` from ((`group_buy_topic_goods` join `goods` on((`group_buy_topic_goods`.`goods_id` = `goods`.`id`))) join `group_buy` on((`group_buy_topic_goods`.`group_buy_id` = `group_buy`.`id`))) where (`goods`.`status` = 3) ;

-- ----------------------------
-- View structure for v_group_buy_topic_manager
-- ----------------------------
DROP VIEW IF EXISTS `v_group_buy_topic_manager`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_group_buy_topic_manager` AS select `group_buy_topic`.`id` AS `id`,`group_buy_topic`.`css_type` AS `css_type`,`group_buy_topic`.`u_id` AS `u_id`,`group_buy_topic`.`view_count` AS `view_count`,`group_buy_topic`.`create_time` AS `create_time`,`member`.`username` AS `username`,`member`.`nickname` AS `nickname` from (`group_buy_topic` join `member` on((`group_buy_topic`.`u_id` = `member`.`id`))) ;

-- ----------------------------
-- View structure for v_helpdoc_typeid
-- ----------------------------
DROP VIEW IF EXISTS `v_helpdoc_typeid`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_helpdoc_typeid` AS select `help_doc`.`id` AS `id`,`help_doc`.`title` AS `title` from `help_doc` where (`help_doc`.`status` = 1) ;

-- ----------------------------
-- View structure for v_her_plan_list
-- ----------------------------
DROP VIEW IF EXISTS `v_her_plan_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_her_plan_list` AS select `her_plan`.`id` AS `id`,`her_plan`.`content` AS `content`,`her_plan`.`picpath` AS `picpath`,`her_plan`.`linkurl` AS `linkurl`,`her_plan`.`uid` AS `uid`,`her_plan`.`person_picpath` AS `person_picpath`,`her_plan`.`person_name` AS `person_name`,`her_plan`.`person_summary` AS `person_summary`,`her_plan`.`show_main_page` AS `show_main_page`,`her_plan`.`status` AS `status`,`her_plan`.`create_time` AS `create_time`,`member`.`nickname` AS `nickname`,`member`.`feeling` AS `feeling`,`member`.`picpath` AS `m_picpath`,`her_plan`.`sequence` AS `sequence`,`member`.`username` AS `username`,`her_plan`.`summery` AS `summery` from (`her_plan` left join `member` on(((`member`.`id` = `her_plan`.`uid`) and (`her_plan`.`status` < 99)))) ;

-- ----------------------------
-- View structure for v_import_st
-- ----------------------------
DROP VIEW IF EXISTS `v_import_st`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_import_st` AS select `v_goods_list`.`name` AS `name`,`v_goods_list`.`price` AS `price`,`v_goods_list`.`category_name3` AS `category_name3`,`talent_import_fans`.`create_time` AS `create_time`,`talent_import_fans`.`goodsid` AS `goodsid` from (`talent_import_fans` join `v_goods_list` on((`talent_import_fans`.`goodsid` = `v_goods_list`.`id`))) ;

-- ----------------------------
-- View structure for v_log_goods_visit_history
-- ----------------------------
DROP VIEW IF EXISTS `v_log_goods_visit_history`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_log_goods_visit_history` AS select `log_goods_visit_history`.`id` AS `id`,`log_goods_visit_history`.`u_id` AS `u_id`,`log_goods_visit_history`.`goodsid` AS `goodsid`,`log_goods_visit_history`.`status` AS `status`,`log_goods_visit_history`.`create_time` AS `create_time`,`goods`.`name` AS `name`,`goods`.`sale_price` AS `sale_price`,`goods`.`price` AS `price`,`goods`.`title_pic` AS `title_pic` from (`log_goods_visit_history` join `goods` on((`log_goods_visit_history`.`goodsid` = `goods`.`id`))) where (`log_goods_visit_history`.`status` = 0) ;

-- ----------------------------
-- View structure for v_log_points_mall
-- ----------------------------
DROP VIEW IF EXISTS `v_log_points_mall`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_log_points_mall` AS select `log_points_mall`.`id` AS `id`,`log_points_mall`.`u_id` AS `u_id`,`log_points_mall`.`ticketid` AS `ticketid`,`log_points_mall`.`ticket_points` AS `ticket_points`,`log_points_mall`.`fire_member_points` AS `fire_member_points`,`log_points_mall`.`create_time` AS `create_time`,`ticket`.`name` AS `ticket_name`,`member`.`points` AS `points`,`member`.`username` AS `username`,`member`.`nickname` AS `nickname`,`ticket`.`picurl` AS `picurl` from ((`log_points_mall` join `ticket` on((`log_points_mall`.`ticketid` = `ticket`.`id`))) join `member` on((`log_points_mall`.`u_id` = `member`.`id`))) ;

-- ----------------------------
-- View structure for v_log_tryout_report_visit_history
-- ----------------------------
DROP VIEW IF EXISTS `v_log_tryout_report_visit_history`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_log_tryout_report_visit_history` AS select `log_tryout_report_visit_history`.`create_time` AS `create_time`,`log_tryout_report_visit_history`.`id` AS `id`,`log_tryout_report_visit_history`.`u_id` AS `u_id`,`log_tryout_report_visit_history`.`reportid` AS `reportid`,`member`.`nickname` AS `nickname`,`member`.`username` AS `username` from (`log_tryout_report_visit_history` join `member` on((`log_tryout_report_visit_history`.`u_id` = `member`.`id`))) ;

-- ----------------------------
-- View structure for v_logistics_cost_list
-- ----------------------------
DROP VIEW IF EXISTS `v_logistics_cost_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_logistics_cost_list` AS select `city_zone`.`name` AS `name`,`logistics_cost`.`id` AS `id`,`logistics_cost`.`cost` AS `cost`,`logistics_cost`.`status` AS `status`,`logistics_cost`.`province_id` AS `province_id` from (`city_zone` join `logistics_cost` on((`logistics_cost`.`province_id` = `city_zone`.`id`))) ;
-- ----------------------------
-- View structure for v_main_no_recommend_group_goods
-- ----------------------------
DROP VIEW IF EXISTS `v_main_no_recommend_group_goods`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_main_no_recommend_group_goods` AS select `group_buy`.`id` AS `id`,`group_buy`.`goodsid` AS `goodsid`,0 AS `recommend_id`,0 AS `talent_id`,0 AS `tryout_report_id`,'' AS `tryout_report_content`,0 AS `sequence`,`goods`.`name` AS `name`,`goods`.`title_pic` AS `title_pic`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price`,`goods`.`sale_count` AS `goods_sale_count`,`goods`.`base_sale_count` AS `goods_base_sale_count`,'' AS `title`,`group_buy`.`picpath` AS `picpath`,`group_buy`.`end_time` AS `group_end_time`,`group_buy`.`start_time` AS `group_start_time`,`group_buy`.`sale_count` AS `group_sale_count`,`group_buy`.`base_sale_count` AS `base_group_sale_count`,`group_buy`.`sale_price` AS `group_sale_price`,`group_buy`.`small_price` AS `small_price`,'' AS `nickname`,'' AS `member_picpath`,'' AS `feeling`,`group_buy`.`id` AS `group_buy_id`,1 AS `gsequence` from (`group_buy` join `goods` on(((`group_buy`.`goodsid` = `goods`.`id`) and (`goods`.`status` = 3)))) where ((`group_buy`.`end_time` >= now()) and ((`group_buy`.`status` = 3) or isnull(`group_buy`.`status`)) and (not(`group_buy`.`id` in (select `main_cfg_recommend`.`group_buy_id` from `main_cfg_recommend` where ((`main_cfg_recommend`.`status` = 1) and (`main_cfg_recommend`.`group_buy_id` <> '0')))))) order by `group_buy`.`start_time` ;

-- ----------------------------
-- View structure for v_main_recommend_goods
-- ----------------------------
DROP VIEW IF EXISTS `v_main_recommend_goods`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_main_recommend_goods` AS select 0 AS `id`,`main_cfg_recommend`.`goodsid` AS `goodsid`,`main_cfg_recommend`.`id` AS `recommend_id`,`main_cfg_recommend`.`talent_id` AS `talent_id`,`main_cfg_recommend`.`tryout_report_id` AS `tryout_report_id`,`main_cfg_recommend`.`tryout_report_content` AS `tryout_report_content`,`main_cfg_recommend`.`sequence` AS `sequence`,`goods`.`name` AS `name`,`goods`.`title_pic` AS `title_pic`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price`,`goods`.`sale_count` AS `goods_sale_count`,`goods`.`base_sale_count` AS `goods_base_sale_count`,`tryout_report`.`title` AS `title`,NULL AS `picpath`,NULL AS `group_end_time`,NULL AS `group_start_time`,0 AS `group_sale_count`,0 AS `base_group_sale_count`,0 AS `group_sale_price`,0 AS `small_price`,`member`.`nickname` AS `nickname`,`member`.`picpath` AS `member_picpath`,`member`.`feeling` AS `feeling`,`main_cfg_recommend`.`group_buy_id` AS `group_buy_id`,0 AS `gsequence`,`main_cfg_recommend`.`status` AS `main_status`,`goods`.`status` AS `status` from (((`main_cfg_recommend` join `goods` on(((`main_cfg_recommend`.`goodsid` = `goods`.`id`) and (`goods`.`status` = 3)))) left join `tryout_report` on(((`main_cfg_recommend`.`tryout_report_id` = `tryout_report`.`id`) and (`tryout_report`.`status` = 3)))) left join `member` on((`main_cfg_recommend`.`talent_id` = `member`.`id`))) where (((`main_cfg_recommend`.`group_buy_id` = '0') or isnull(`main_cfg_recommend`.`group_buy_id`)) and (`main_cfg_recommend`.`status` = 1)) ;

-- ----------------------------
-- View structure for v_main_recommend_group_goods
-- ----------------------------
DROP VIEW IF EXISTS `v_main_recommend_group_goods`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_main_recommend_group_goods` AS select `group_buy`.`id` AS `id`,`group_buy`.`goodsid` AS `goodsid`,`main_cfg_recommend`.`id` AS `recommend_id`,`main_cfg_recommend`.`talent_id` AS `talent_id`,`main_cfg_recommend`.`tryout_report_id` AS `tryout_report_id`,`main_cfg_recommend`.`tryout_report_content` AS `tryout_report_content`,`main_cfg_recommend`.`sequence` AS `sequence`,`goods`.`name` AS `name`,`goods`.`title_pic` AS `title_pic`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price`,`goods`.`sale_count` AS `goods_sale_count`,`goods`.`base_sale_count` AS `goods_base_sale_count`,`tryout_report`.`title` AS `title`,`group_buy`.`picpath` AS `picpath`,`group_buy`.`end_time` AS `group_end_time`,`group_buy`.`start_time` AS `group_start_time`,`group_buy`.`sale_count` AS `group_sale_count`,`group_buy`.`base_sale_count` AS `base_group_sale_count`,`group_buy`.`sale_price` AS `group_sale_price`,`group_buy`.`small_price` AS `small_price`,`member`.`nickname` AS `nickname`,`member`.`picpath` AS `member_picpath`,`member`.`feeling` AS `feeling`,`group_buy`.`id` AS `group_buy_id`,2 AS `gsequence` from ((((`group_buy` join `goods` on(((`group_buy`.`goodsid` = `goods`.`id`) and (`goods`.`status` = 3)))) join `main_cfg_recommend` on(((`main_cfg_recommend`.`group_buy_id` = `group_buy`.`id`) and (`main_cfg_recommend`.`status` = 1)))) left join `tryout_report` on(((`main_cfg_recommend`.`tryout_report_id` = `tryout_report`.`id`) and (`tryout_report`.`status` = 3)))) left join `member` on((`main_cfg_recommend`.`talent_id` = `member`.`id`))) where ((`group_buy`.`end_time` >= now()) and ((`group_buy`.`status` = 3) or isnull(`group_buy`.`status`))) ;

-- ----------------------------
-- View structure for v_main_cfg_her_plan
-- ----------------------------
DROP VIEW IF EXISTS `v_main_cfg_her_plan`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_main_cfg_her_plan` AS select `her_plan`.`id` AS `id`,`her_plan`.`content` AS `content`,`her_plan`.`picpath` AS `picpath`,`her_plan`.`linkurl` AS `linkurl`,`her_plan`.`uid` AS `uid`,`her_plan`.`person_picpath` AS `person_picpath`,`her_plan`.`person_name` AS `person_name`,`her_plan`.`person_summary` AS `person_summary`,`her_plan`.`show_main_page` AS `show_main_page`,`her_plan`.`status` AS `status`,`member`.`nickname` AS `nickname`,`member`.`picpath` AS `m_picpath`,`member`.`feeling` AS `feeling`,`her_plan`.`summery` AS `summery` from (`her_plan` left join `member` on((`her_plan`.`uid` = `member`.`id`))) where ((`her_plan`.`show_main_page` = 1) and (`her_plan`.`status` = 1)) ;

-- ----------------------------
-- View structure for v_main_cfg_hot_list
-- ----------------------------
DROP VIEW IF EXISTS `v_main_cfg_hot_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_main_cfg_hot_list` AS select `main_cfg_hot_class`.`id` AS `id`,`main_cfg_hot_class`.`goods_category_id` AS `goods_category_id`,`main_cfg_hot_class`.`sequence` AS `sequence`,`main_cfg_hot_class`.`picurl` AS `picurl`,`main_cfg_hot_class`.`status` AS `status`,`goods_category`.`name` AS `name`,`goods_category`.`pid` AS `pid`,`goods_category`.`id` AS `cid` from (`main_cfg_hot_class` join `goods_category` on((`goods_category`.`id` = `main_cfg_hot_class`.`goods_category_id`))) ;

-- ----------------------------
-- View structure for v_main_cfg_recommend
-- ----------------------------
DROP VIEW IF EXISTS `v_main_cfg_recommend`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_main_cfg_recommend` AS select `v_main_recommend_group_goods`.`id` AS `id`,`v_main_recommend_group_goods`.`goodsid` AS `goodsid`,`v_main_recommend_group_goods`.`recommend_id` AS `recommend_id`,`v_main_recommend_group_goods`.`talent_id` AS `talent_id`,`v_main_recommend_group_goods`.`tryout_report_id` AS `tryout_report_id`,`v_main_recommend_group_goods`.`tryout_report_content` AS `tryout_report_content`,`v_main_recommend_group_goods`.`sequence` AS `sequence`,`v_main_recommend_group_goods`.`name` AS `name`,`v_main_recommend_group_goods`.`title_pic` AS `title_pic`,`v_main_recommend_group_goods`.`price` AS `price`,`v_main_recommend_group_goods`.`sale_price` AS `sale_price`,`v_main_recommend_group_goods`.`goods_sale_count` AS `goods_sale_count`,`v_main_recommend_group_goods`.`goods_base_sale_count` AS `goods_base_sale_count`,`v_main_recommend_group_goods`.`title` AS `title`,`v_main_recommend_group_goods`.`picpath` AS `picpath`,`v_main_recommend_group_goods`.`group_end_time` AS `group_end_time`,`v_main_recommend_group_goods`.`group_start_time` AS `group_start_time`,`v_main_recommend_group_goods`.`group_sale_count` AS `group_sale_count`,`v_main_recommend_group_goods`.`base_group_sale_count` AS `base_group_sale_count`,`v_main_recommend_group_goods`.`group_sale_price` AS `group_sale_price`,`v_main_recommend_group_goods`.`small_price` AS `small_price`,`v_main_recommend_group_goods`.`nickname` AS `nickname`,`v_main_recommend_group_goods`.`member_picpath` AS `member_picpath`,`v_main_recommend_group_goods`.`feeling` AS `feeling`,`v_main_recommend_group_goods`.`group_buy_id` AS `group_buy_id`,`v_main_recommend_group_goods`.`gsequence` AS `gsequence` from `v_main_recommend_group_goods` union all select `v_main_no_recommend_group_goods`.`id` AS `id`,`v_main_no_recommend_group_goods`.`goodsid` AS `goodsid`,`v_main_no_recommend_group_goods`.`recommend_id` AS `recommend_id`,`v_main_no_recommend_group_goods`.`talent_id` AS `talent_id`,`v_main_no_recommend_group_goods`.`tryout_report_id` AS `tryout_report_id`,`v_main_no_recommend_group_goods`.`tryout_report_content` AS `tryout_report_content`,`v_main_no_recommend_group_goods`.`sequence` AS `sequence`,`v_main_no_recommend_group_goods`.`name` AS `name`,`v_main_no_recommend_group_goods`.`title_pic` AS `title_pic`,`v_main_no_recommend_group_goods`.`price` AS `price`,`v_main_no_recommend_group_goods`.`sale_price` AS `sale_price`,`v_main_no_recommend_group_goods`.`goods_sale_count` AS `goods_sale_count`,`v_main_no_recommend_group_goods`.`goods_base_sale_count` AS `goods_base_sale_count`,`v_main_no_recommend_group_goods`.`title` AS `title`,`v_main_no_recommend_group_goods`.`picpath` AS `picpath`,`v_main_no_recommend_group_goods`.`group_end_time` AS `group_end_time`,`v_main_no_recommend_group_goods`.`group_start_time` AS `group_start_time`,`v_main_no_recommend_group_goods`.`group_sale_count` AS `group_sale_count`,`v_main_no_recommend_group_goods`.`base_group_sale_count` AS `base_group_sale_count`,`v_main_no_recommend_group_goods`.`group_sale_price` AS `group_sale_price`,`v_main_no_recommend_group_goods`.`small_price` AS `small_price`,`v_main_no_recommend_group_goods`.`nickname` AS `nickname`,`v_main_no_recommend_group_goods`.`member_picpath` AS `member_picpath`,`v_main_no_recommend_group_goods`.`feeling` AS `feeling`,`v_main_no_recommend_group_goods`.`group_buy_id` AS `group_buy_id`,`v_main_no_recommend_group_goods`.`gsequence` AS `gsequence` from `v_main_no_recommend_group_goods` union all select `v_main_recommend_goods`.`id` AS `id`,`v_main_recommend_goods`.`goodsid` AS `goodsid`,`v_main_recommend_goods`.`recommend_id` AS `recommend_id`,`v_main_recommend_goods`.`talent_id` AS `talent_id`,`v_main_recommend_goods`.`tryout_report_id` AS `tryout_report_id`,`v_main_recommend_goods`.`tryout_report_content` AS `tryout_report_content`,`v_main_recommend_goods`.`sequence` AS `sequence`,`v_main_recommend_goods`.`name` AS `name`,`v_main_recommend_goods`.`title_pic` AS `title_pic`,`v_main_recommend_goods`.`price` AS `price`,`v_main_recommend_goods`.`sale_price` AS `sale_price`,`v_main_recommend_goods`.`goods_sale_count` AS `goods_sale_count`,`v_main_recommend_goods`.`goods_base_sale_count` AS `goods_base_sale_count`,`v_main_recommend_goods`.`title` AS `title`,`v_main_recommend_goods`.`picpath` AS `picpath`,`v_main_recommend_goods`.`group_end_time` AS `group_end_time`,`v_main_recommend_goods`.`group_start_time` AS `group_start_time`,`v_main_recommend_goods`.`group_sale_count` AS `group_sale_count`,`v_main_recommend_goods`.`base_group_sale_count` AS `base_group_sale_count`,`v_main_recommend_goods`.`group_sale_price` AS `group_sale_price`,`v_main_recommend_goods`.`small_price` AS `small_price`,`v_main_recommend_goods`.`nickname` AS `nickname`,`v_main_recommend_goods`.`member_picpath` AS `member_picpath`,`v_main_recommend_goods`.`feeling` AS `feeling`,`v_main_recommend_goods`.`group_buy_id` AS `group_buy_id`,`v_main_recommend_goods`.`gsequence` AS `gsequence` from `v_main_recommend_goods` ;

-- ----------------------------
-- View structure for v_main_cfg_recommend_copy
-- ----------------------------
DROP VIEW IF EXISTS `v_main_cfg_recommend_copy`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_main_cfg_recommend_copy` AS select `v_main_recommend_group_goods`.`id` AS `id`,`v_main_recommend_group_goods`.`goodsid` AS `goodsid`,`v_main_recommend_group_goods`.`recommend_id` AS `recommend_id`,`v_main_recommend_group_goods`.`talent_id` AS `talent_id`,`v_main_recommend_group_goods`.`tryout_report_id` AS `tryout_report_id`,`v_main_recommend_group_goods`.`tryout_report_content` AS `tryout_report_content`,`v_main_recommend_group_goods`.`sequence` AS `sequence`,`v_main_recommend_group_goods`.`name` AS `name`,`v_main_recommend_group_goods`.`title_pic` AS `title_pic`,`v_main_recommend_group_goods`.`price` AS `price`,`v_main_recommend_group_goods`.`sale_price` AS `sale_price`,`v_main_recommend_group_goods`.`goods_sale_count` AS `goods_sale_count`,`v_main_recommend_group_goods`.`goods_base_sale_count` AS `goods_base_sale_count`,`v_main_recommend_group_goods`.`title` AS `title`,`v_main_recommend_group_goods`.`picpath` AS `picpath`,`v_main_recommend_group_goods`.`group_end_time` AS `group_end_time`,`v_main_recommend_group_goods`.`group_start_time` AS `group_start_time`,`v_main_recommend_group_goods`.`group_sale_count` AS `group_sale_count`,`v_main_recommend_group_goods`.`base_group_sale_count` AS `base_group_sale_count`,`v_main_recommend_group_goods`.`group_sale_price` AS `group_sale_price`,`v_main_recommend_group_goods`.`small_price` AS `small_price`,`v_main_recommend_group_goods`.`nickname` AS `nickname`,`v_main_recommend_group_goods`.`member_picpath` AS `member_picpath`,`v_main_recommend_group_goods`.`feeling` AS `feeling`,`v_main_recommend_group_goods`.`group_buy_id` AS `group_buy_id`,`v_main_recommend_group_goods`.`gsequence` AS `gsequence` from `v_main_recommend_group_goods` union all select `v_main_no_recommend_group_goods`.`id` AS `id`,`v_main_no_recommend_group_goods`.`goodsid` AS `goodsid`,`v_main_no_recommend_group_goods`.`recommend_id` AS `recommend_id`,`v_main_no_recommend_group_goods`.`talent_id` AS `talent_id`,`v_main_no_recommend_group_goods`.`tryout_report_id` AS `tryout_report_id`,`v_main_no_recommend_group_goods`.`tryout_report_content` AS `tryout_report_content`,`v_main_no_recommend_group_goods`.`sequence` AS `sequence`,`v_main_no_recommend_group_goods`.`name` AS `name`,`v_main_no_recommend_group_goods`.`title_pic` AS `title_pic`,`v_main_no_recommend_group_goods`.`price` AS `price`,`v_main_no_recommend_group_goods`.`sale_price` AS `sale_price`,`v_main_no_recommend_group_goods`.`goods_sale_count` AS `goods_sale_count`,`v_main_no_recommend_group_goods`.`goods_base_sale_count` AS `goods_base_sale_count`,`v_main_no_recommend_group_goods`.`title` AS `title`,`v_main_no_recommend_group_goods`.`picpath` AS `picpath`,`v_main_no_recommend_group_goods`.`group_end_time` AS `group_end_time`,`v_main_no_recommend_group_goods`.`group_start_time` AS `group_start_time`,`v_main_no_recommend_group_goods`.`group_sale_count` AS `group_sale_count`,`v_main_no_recommend_group_goods`.`base_group_sale_count` AS `base_group_sale_count`,`v_main_no_recommend_group_goods`.`group_sale_price` AS `group_sale_price`,`v_main_no_recommend_group_goods`.`small_price` AS `small_price`,`v_main_no_recommend_group_goods`.`nickname` AS `nickname`,`v_main_no_recommend_group_goods`.`member_picpath` AS `member_picpath`,`v_main_no_recommend_group_goods`.`feeling` AS `feeling`,`v_main_no_recommend_group_goods`.`group_buy_id` AS `group_buy_id`,`v_main_no_recommend_group_goods`.`gsequence` AS `gsequence` from `v_main_no_recommend_group_goods` union all select `v_main_recommend_goods`.`id` AS `id`,`v_main_recommend_goods`.`goodsid` AS `goodsid`,`v_main_recommend_goods`.`recommend_id` AS `recommend_id`,`v_main_recommend_goods`.`talent_id` AS `talent_id`,`v_main_recommend_goods`.`tryout_report_id` AS `tryout_report_id`,`v_main_recommend_goods`.`tryout_report_content` AS `tryout_report_content`,`v_main_recommend_goods`.`sequence` AS `sequence`,`v_main_recommend_goods`.`name` AS `name`,`v_main_recommend_goods`.`title_pic` AS `title_pic`,`v_main_recommend_goods`.`price` AS `price`,`v_main_recommend_goods`.`sale_price` AS `sale_price`,`v_main_recommend_goods`.`goods_sale_count` AS `goods_sale_count`,`v_main_recommend_goods`.`goods_base_sale_count` AS `goods_base_sale_count`,`v_main_recommend_goods`.`title` AS `title`,`v_main_recommend_goods`.`picpath` AS `picpath`,`v_main_recommend_goods`.`group_end_time` AS `group_end_time`,`v_main_recommend_goods`.`group_start_time` AS `group_start_time`,`v_main_recommend_goods`.`group_sale_count` AS `group_sale_count`,`v_main_recommend_goods`.`base_group_sale_count` AS `base_group_sale_count`,`v_main_recommend_goods`.`group_sale_price` AS `group_sale_price`,`v_main_recommend_goods`.`small_price` AS `small_price`,`v_main_recommend_goods`.`nickname` AS `nickname`,`v_main_recommend_goods`.`member_picpath` AS `member_picpath`,`v_main_recommend_goods`.`feeling` AS `feeling`,`v_main_recommend_goods`.`group_buy_id` AS `group_buy_id`,`v_main_recommend_goods`.`gsequence` AS `gsequence` from `v_main_recommend_goods` ;

-- ----------------------------
-- View structure for v_main_cfg_recommend_manager
-- ----------------------------
DROP VIEW IF EXISTS `v_main_cfg_recommend_manager`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_main_cfg_recommend_manager` AS select `main_cfg_recommend`.`id` AS `id`,`main_cfg_recommend`.`goodsid` AS `goodsid`,`main_cfg_recommend`.`talent_id` AS `talent_id`,`main_cfg_recommend`.`tryout_report_id` AS `tryout_report_id`,`main_cfg_recommend`.`tryout_report_content` AS `tryout_report_content`,`main_cfg_recommend`.`sequence` AS `sequence`,`main_cfg_recommend`.`status` AS `status`,`goods`.`name` AS `name`,`goods`.`title_pic` AS `title_pic`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price`,`goods`.`sale_count` AS `goods_sale_count`,`goods`.`base_sale_count` AS `goods_base_sale_count`,`tryout_report`.`title` AS `title`,`group_buy`.`picpath` AS `picpath`,`group_buy`.`end_time` AS `group_end_time`,`group_buy`.`start_time` AS `group_start_time`,`group_buy`.`sale_count` AS `group_sale_count`,`group_buy`.`base_sale_count` AS `base_group_sale_count`,`group_buy`.`sale_price` AS `group_sale_price`,`group_buy`.`small_price` AS `small_price`,`member`.`nickname` AS `nickname`,`member`.`picpath` AS `member_picpath`,`member`.`feeling` AS `feeling`,`group_buy`.`id` AS `group_buy_id`,(case when isnull(`group_buy`.`id`) then 0 else 1 end) AS `gsequence` from ((((`main_cfg_recommend` join `goods` on(((`main_cfg_recommend`.`goodsid` = `goods`.`id`) and (`goods`.`status` = 3)))) left join `group_buy` on((`main_cfg_recommend`.`group_buy_id` = `group_buy`.`id`))) left join `tryout_report` on(((`main_cfg_recommend`.`tryout_report_id` = `tryout_report`.`id`) and (`tryout_report`.`status` = 3)))) left join `member` on((`main_cfg_recommend`.`talent_id` = `member`.`id`))) where (((`main_cfg_recommend`.`status` = 1) and (`group_buy`.`status` = 3)) or isnull(`group_buy`.`status`)) ;

-- ----------------------------
-- View structure for v_main_cfg_video
-- ----------------------------
DROP VIEW IF EXISTS `v_main_cfg_video`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_main_cfg_video` AS select `main_cfg_video`.`id` AS `id`,`main_cfg_video`.`video_id` AS `video_id`,`main_cfg_video`.`sequence` AS `sequence`,`main_cfg_video`.`status` AS `status`,`video`.`videopath` AS `videopath`,`video`.`baby_name` AS `baby_name`,`video`.`view_count` AS `view_count`,`video`.`summary` AS `summary`,`video`.`first_img_path` AS `first_img_path`,`main_cfg_video`.`video_img` AS `video_img`,`video`.`title` AS `title` from (`main_cfg_video` join `video` on((`main_cfg_video`.`video_id` = `video`.`id`))) ;

-- ----------------------------
-- View structure for v_member_talent
-- ----------------------------
DROP VIEW IF EXISTS `v_member_talent`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_member_talent` AS select `talent`.`u_id` AS `u_id`,`talent`.`get_price_all` AS `get_price_all`,`talent`.`groupbuy_get_count` AS `groupbuy_get_count`,`member`.`id` AS `id`,`talent`.`id` AS `talentid`,`talent`.`has_new_group_buy` AS `has_new_group_buy`,`talent`.`has_new_import` AS `has_new_import`,`talent`.`has_new_order` AS `has_new_order`,`talent`.`has_new_fee` AS `has_new_fee` from (`member` join `talent` on((`talent`.`u_id` = `member`.`id`))) where (`talent`.`status` = 3) ;


-- ----------------------------
-- View structure for v_menu_root
-- ----------------------------
DROP VIEW IF EXISTS `v_menu_root`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_menu_root` AS select `menu`.`id` AS `id`,`menu`.`name` AS `name`,`menu`.`order_code` AS `order_code` from `menu` where (`menu`.`pid` = 0) ;

-- ----------------------------
-- View structure for v_menu_second
-- ----------------------------
DROP VIEW IF EXISTS `v_menu_second`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_menu_second` AS select `menu`.`id` AS `id`,`menu`.`name` AS `name`,`menu`.`url` AS `url`,`menu`.`order_code` AS `order_code`,`menu`.`pid` AS `pid` from `menu` where (`menu`.`deep` = 2) ;

-- ----------------------------
-- View structure for v_message_chat
-- ----------------------------
DROP VIEW IF EXISTS `v_message_chat`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_message_chat` AS select `message_chat`.`id` AS `id`,`message_chat`.`category` AS `category`,`message_chat`.`content` AS `content`,`message_chat`.`fr_id` AS `fr_id`,`message_chat`.`to_id` AS `to_id`,`message_chat`.`status` AS `status`,`message_chat`.`create_time` AS `create_time`,`m_from`.`nickname` AS `from_nick`,`m_from`.`picpath` AS `from_head_pic`,`m_to`.`nickname` AS `to_nick`,`m_to`.`picpath` AS `to_head_pic`,`message_chat`.`data_type` AS `data_type` from ((`message_chat` join `member` `m_from` on(((`message_chat`.`fr_id` = `m_from`.`id`) and (`message_chat`.`status` < 9)))) join `member` `m_to` on((`message_chat`.`to_id` = `m_to`.`id`))) ;
-- ----------------------------
-- View structure for v_menu_list
-- ----------------------------
DROP VIEW IF EXISTS `v_menu_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_menu_list` AS select `v_menu_second`.`id` AS `id`,`v_menu_second`.`name` AS `name`,`v_menu_second`.`url` AS `url`,`v_menu_second`.`order_code` AS `order_code`,`v_menu_root`.`id` AS `root_id`,`v_menu_root`.`name` AS `root_name` from (`v_menu_root` join `v_menu_second` on((`v_menu_root`.`id` = `v_menu_second`.`pid`))) order by `v_menu_root`.`id` ;

-- ----------------------------
-- View structure for v_message_chat_count
-- ----------------------------
DROP VIEW IF EXISTS `v_message_chat_count`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_message_chat_count` AS select count(1) AS `count`,`message_chat`.`fr_id` AS `fr_id`,`message_chat`.`to_id` AS `to_id` from `message_chat` where ((`message_chat`.`category` = 3) and (`message_chat`.`status` = 0)) group by `message_chat`.`fr_id`,`message_chat`.`to_id` ;

-- ----------------------------
-- View structure for v_message_chat_new
-- ----------------------------
DROP VIEW IF EXISTS `v_message_chat_new`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_message_chat_new` AS select `message_chat`.`fr_id` AS `fr_id`,`message_chat`.`to_id` AS `to_id`,max(`message_chat`.`create_time`) AS `create_time`,max(`message_chat`.`id`) AS `id` from `message_chat` where ((`message_chat`.`category` = 3) and ((`message_chat`.`status` = 0) or (`message_chat`.`status` = 1))) group by `message_chat`.`fr_id`,`message_chat`.`to_id` ;

-- ----------------------------
-- View structure for v_message_chat_union
-- ----------------------------
DROP VIEW IF EXISTS `v_message_chat_union`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_message_chat_union` AS select `message_chat`.`id` AS `id`,`message_chat`.`category` AS `category`,`message_chat`.`data_type` AS `data_type`,`message_chat`.`content` AS `content`,`message_chat`.`fr_id` AS `fr_id`,`message_chat`.`to_id` AS `to_id`,`message_chat`.`points` AS `points`,`message_chat`.`total_points` AS `total_points`,`message_chat`.`status` AS `status`,`message_chat`.`create_time` AS `create_time`,`message_chat`.`update_time` AS `update_time`,(case when (`message_chat`.`fr_id` < `message_chat`.`to_id`) then concat(`message_chat`.`fr_id`,'_',`message_chat`.`to_id`) when (`message_chat`.`fr_id` > `message_chat`.`to_id`) then concat(`message_chat`.`to_id`,'_',`message_chat`.`fr_id`) else concat(`message_chat`.`fr_id`,'_',`message_chat`.`to_id`) end) AS `unionId`,concat(`message_chat`.`fr_id`,'_',`message_chat`.`to_id`) AS `fr` from `message_chat` ;

-- ----------------------------
-- View structure for v_message_info
-- ----------------------------
DROP VIEW IF EXISTS `v_message_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_message_info` AS select `message_info`.`id` AS `id`,`message_info`.`category` AS `category`,`message_info`.`list_id` AS `list_id`,`message_info`.`to_id` AS `to_id`,`message_info`.`status` AS `status`,`message_info`.`create_time` AS `create_time`,`message_list`.`title` AS `title`,`message_list`.`content` AS `content`,`message_list`.`picpath` AS `picpath`,`message_list`.`piclink` AS `piclink`,`message_list`.`op_u_id` AS `op_u_id`,`member`.`nickname` AS `oper_nick`,`member`.`picpath` AS `oper_head_pic` from ((`message_info` join `message_list` on(((`message_info`.`list_id` = `message_list`.`id`) and (`message_info`.`status` < 9)))) join `member` on((`message_list`.`op_u_id` = `member`.`id`))) ;

-- ----------------------------
-- View structure for v_message_list
-- ----------------------------
DROP VIEW IF EXISTS `v_message_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_message_list` AS select `message_list`.`id` AS `id`,`message_list`.`category` AS `category`,`message_list`.`title` AS `title`,`message_list`.`content` AS `content`,`message_list`.`picpath` AS `picpath`,`message_list`.`piclink` AS `piclink`,`message_list`.`status` AS `status`,`message_list`.`create_time` AS `create_time`,`memberfrom`.`nickname` AS `nickname`,`message_list`.`op_u_id` AS `op_u_id` from (`message_list` join `member` `memberfrom` on((`memberfrom`.`id` = `message_list`.`op_u_id`))) ;

-- ----------------------------
-- View structure for v_message_logistics
-- ----------------------------
DROP VIEW IF EXISTS `v_message_logistics`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_message_logistics` AS select `message_chat`.`id` AS `id`,`message_chat`.`category` AS `category`,`message_chat`.`content` AS `content`,`message_chat`.`fr_id` AS `fr_id`,`message_chat`.`to_id` AS `to_id`,`message_chat`.`status` AS `status`,`message_chat`.`create_time` AS `create_time`,`m_to`.`nickname` AS `to_nick`,`m_to`.`picpath` AS `to_head_pic`,`message_chat`.`data_type` AS `data_type`,`order_item`.`logistics_name` AS `logistics_name`,`order_item`.`logistics_number` AS `logistics_number`,`order_item`.`logistics_code` AS `logistics_code`,`order_item`.`goodsid` AS `goodsid`,`goods`.`name` AS `name`,`order_item`.`speci_pic_url` AS `title_pic` from (((`message_chat` join `member` `m_to` on((`message_chat`.`to_id` = `m_to`.`id`))) join `order_item` on((`message_chat`.`fr_id` = `order_item`.`id`))) join `goods` on((`order_item`.`goodsid` = `goods`.`id`))) ;

-- ----------------------------
-- View structure for v_message_score
-- ----------------------------
DROP VIEW IF EXISTS `v_message_score`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_message_score` AS select `message_chat`.`id` AS `id`,`message_chat`.`category` AS `category`,`message_chat`.`data_type` AS `data_type`,`message_chat`.`content` AS `content`,`message_chat`.`fr_id` AS `fr_id`,`message_chat`.`to_id` AS `to_id`,`message_chat`.`points` AS `points`,`message_chat`.`total_points` AS `total_points`,`message_chat`.`status` AS `status`,`message_chat`.`create_time` AS `create_time`,(case when isnull(`order_item`.`name`) then `ticket`.`name` else `order_item`.`name` end) AS `name` from ((`message_chat` left join `order_item` on((`message_chat`.`fr_id` = `order_item`.`id`))) left join `ticket` on((`message_chat`.`fr_id` = `ticket`.`id`))) where (`message_chat`.`category` = 9) ;

-- ----------------------------
-- View structure for v_my_base_info
-- ----------------------------
DROP VIEW IF EXISTS `v_my_base_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_my_base_info` AS select `member`.`id` AS `id`,`member`.`username` AS `username`,`member`.`nickname` AS `nickname`,`member`.`gender` AS `gender`,`member`.`cardnum` AS `cardnum`,`member`.`realname` AS `realname` from `member` ;

-- ----------------------------
-- View structure for v_my_center_info
-- ----------------------------
DROP VIEW IF EXISTS `v_my_center_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_my_center_info` AS select `member`.`nickname` AS `nickname`,`member`.`picpath` AS `picpath`,`member`.`favorite_count` AS `favorite_count`,`member`.`like_talent_count` AS `like_talent_count`,`member`.`points` AS `points`,`member`.`level` AS `level`,`member`.`check_count` AS `check_count`,`member`.`fans_like_count` AS `fans_like_count`,`member`.`id` AS `id`,`talent`.`refuse_reason` AS `refuse_reason`,`talent`.`create_time` AS `create_time`,`talent`.`has_new_group_buy` AS `has_new_group_buy`,`member`.`has_new_ticket` AS `has_new_ticket`,`talent`.`has_new_import` AS `has_new_import`,`talent`.`has_new_order` AS `has_new_order`,`member`.`has_new_tryout` AS `has_new_tryout` from (`member` left join `talent` on((`member`.`id` = `talent`.`u_id`))) ;

-- ----------------------------
-- View structure for v_my_favorite_goods
-- ----------------------------
DROP VIEW IF EXISTS `v_my_favorite_goods`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_my_favorite_goods` AS select `fans_favorite`.`id` AS `id`,`fans_favorite`.`goodsid` AS `goodsid`,`fans_favorite`.`create_time` AS `create_time`,`fans_favorite`.`status` AS `status`,`goods`.`name` AS `name`,`goods`.`title_pic` AS `title_pic`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price`,(`goods`.`sale_count` + `goods`.`base_sale_count`) AS `sale_count`,`fans_favorite`.`u_id` AS `u_id`,`goods`.`activity_json` AS `activity_json` from (`fans_favorite` join `goods` on((`fans_favorite`.`goodsid` = `goods`.`id`))) ;

-- ----------------------------
-- View structure for v_my_like_talent_list
-- ----------------------------
DROP VIEW IF EXISTS `v_my_like_talent_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_my_like_talent_list` AS select `fans_like_talent`.`id` AS `id`,`fans_like_talent`.`fansid` AS `fansid`,`fans_like_talent`.`status` AS `status`,`member`.`nickname` AS `nickname`,`member`.`picpath` AS `picpath`,`member`.`feeling` AS `feeling`,`member`.`level` AS `level`,`fans_like_talent`.`talentid` AS `talentid` from (`fans_like_talent` join `member` on((`fans_like_talent`.`talentid` = `member`.`id`))) ;
-- ----------------------------
-- View structure for v_order_main_sub_count
-- ----------------------------
DROP VIEW IF EXISTS `v_order_main_sub_count`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_order_main_sub_count` AS select `order_item`.`main_order_id` AS `main_order_id`,count(1) AS `count` from `order_item` group by `order_item`.`main_order_id` ;

-- ----------------------------
-- View structure for v_order_refund_price_new_status
-- ----------------------------
DROP VIEW IF EXISTS `v_order_refund_price_new_status`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_order_refund_price_new_status` AS select `o`.`order_item_id` AS `order_item_id`,`o`.`status` AS `status`,`o`.`order_main_number` AS `order_main_number` from `order_refund_price` `o` where (`o`.`create_time` = (select max(`order_refund_price`.`create_time`) from `order_refund_price` where (`o`.`order_item_id` = `order_refund_price`.`order_item_id`) group by `order_refund_price`.`order_item_id`)) ;

-- ----------------------------
-- View structure for v_order_main_refund_status
-- ----------------------------
DROP VIEW IF EXISTS `v_order_main_refund_status`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_order_main_refund_status` AS select min(`v_order_refund_price_new_status`.`status`) AS `refund_status`,`v_order_refund_price_new_status`.`order_main_number` AS `order_main_number` from `v_order_refund_price_new_status` group by `v_order_refund_price_new_status`.`order_main_number` ;
-- ----------------------------
-- View structure for v_order_refund_apply_min_status
-- ----------------------------
DROP VIEW IF EXISTS `v_order_refund_apply_min_status`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_order_refund_apply_min_status` AS select min(`order_refund_apply`.`status`) AS `status`,`order_refund_apply`.`order_main_number` AS `order_main_number`,`order_refund_apply`.`order_item_id` AS `order_item_id` from `order_refund_apply` group by `order_refund_apply`.`order_main_number` ;

-- ----------------------------
-- View structure for v_my_order_main
-- ----------------------------
DROP VIEW IF EXISTS `v_my_order_main`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_my_order_main` AS select `order_main`.`id` AS `id`,`order_main`.`order_number` AS `order_number`,`order_main`.`u_id` AS `u_id`,`order_main`.`consumption_category` AS `consumption_category`,`order_main`.`status` AS `status`,`order_main`.`amount` AS `amount`,`order_main`.`pay_price` AS `pay_price`,`order_main`.`pay_time` AS `pay_time`,`order_main`.`pay_category` AS `pay_category`,`order_main`.`remark` AS `remark`,`order_main`.`address_id` AS `address_id`,`order_main`.`province_name` AS `province_name`,`order_main`.`city_name` AS `city_name`,`order_main`.`zone_name` AS `zone_name`,`order_main`.`recv_name` AS `recv_name`,`order_main`.`recv_phone` AS `recv_phone`,`order_main`.`address` AS `address`,`order_main`.`is_address_modify` AS `is_address_modify`,`order_main`.`ticket_id` AS `ticket_id`,`order_main`.`vip_id_json` AS `vip_id_json`,`order_main`.`card_pay_price` AS `card_pay_price`,`order_main`.`distributor_json` AS `distributor_json`,`order_main`.`total_price` AS `total_price`,`order_main`.`tran_price` AS `tran_price`,`order_main`.`discount_price` AS `discount_price`,`order_main`.`is_balance` AS `is_balance`,`order_main`.`running_number` AS `running_number`,`order_main`.`wechat_number` AS `wechat_number`,`order_main`.`create_time` AS `create_time`,`order_main`.`update_time` AS `update_time`,`order_main`.`is_show` AS `is_show`,`v_order_main_sub_count`.`count` AS `item_count`,(case when isnull(`v_order_main_refund_status`.`refund_status`) then `v_order_refund_apply_min_status`.`status` when isnull(`v_order_refund_apply_min_status`.`status`) then `v_order_main_refund_status`.`refund_status` when (`v_order_refund_apply_min_status`.`status` > `v_order_main_refund_status`.`refund_status`) then `v_order_main_refund_status`.`refund_status` else `v_order_refund_apply_min_status`.`status` end) AS `refund_status` from (((`order_main` left join `v_order_main_sub_count` on((`order_main`.`id` = `v_order_main_sub_count`.`main_order_id`))) left join `v_order_main_refund_status` on((`order_main`.`order_number` = `v_order_main_refund_status`.`order_main_number`))) left join `v_order_refund_apply_min_status` on((`order_main`.`order_number` = `v_order_refund_apply_min_status`.`order_main_number`))) where (`order_main`.`consumption_category` <> 5) ;

-- ----------------------------
-- View structure for v_my_sign_record
-- ----------------------------
DROP VIEW IF EXISTS `v_my_sign_record`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_my_sign_record` AS select `fans_sign_record`.`sign_index` AS `sign_index`,`fans_sign_record`.`create_time` AS `create_time`,`fans_sign_record`.`fans_id` AS `fans_id`,`fans_sign_record`.`id` AS `id`,`member`.`points` AS `points`,`member`.`picpath` AS `picpath` from (`fans_sign_record` join `member` on((`fans_sign_record`.`fans_id` = `member`.`id`))) where (`fans_sign_record`.`create_time` < now()) ;

-- ----------------------------
-- View structure for v_my_ticket
-- ----------------------------
DROP VIEW IF EXISTS `v_my_ticket`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_my_ticket` AS select `fans_ticket`.`id` AS `id`,`fans_ticket`.`fansid` AS `fansid`,`fans_ticket`.`ticketid` AS `ticketid`,`fans_ticket`.`end_time` AS `end_time`,`fans_ticket`.`status` AS `status`,`ticket`.`type` AS `type`,`ticket`.`name` AS `name`,`ticket`.`price` AS `price`,`ticket_send_rule`.`title` AS `title` from ((`fans_ticket` join `ticket` on((`fans_ticket`.`ticketid` = `ticket`.`id`))) join `ticket_send_rule` on((`fans_ticket`.`sendid` = `ticket_send_rule`.`id`))) ;

-- ----------------------------
-- View structure for v_my_tryout_report
-- ----------------------------
DROP VIEW IF EXISTS `v_my_tryout_report`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_my_tryout_report` AS select `tryout_report`.`id` AS `id`,`tryout_report`.`fansid` AS `fansid`,`tryout_report`.`title` AS `title`,`tryout_report`.`default_pic` AS `default_pic`,`tryout_report`.`status` AS `status`,`tryout_report`.`view_count` AS `view_count`,`tryout_report`.`like_count` AS `like_count`,`tryout_report`.`create_time` AS `create_time`,`tryout_report`.`notpass_reason` AS `notpass_reason` from `tryout_report` ;

-- ----------------------------
-- View structure for v_net_start_detail_goods_view
-- ----------------------------
DROP VIEW IF EXISTS `v_net_start_detail_goods_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_net_start_detail_goods_view` AS select `net_start_goods`.`id` AS `id`,`net_start_goods`.`goodsid` AS `goodsid`,`net_start_goods`.`sale_count` AS `sale_count`,`net_start_goods`.`curr_price` AS `curr_price`,`net_start_goods`.`history_price` AS `history_price`,`net_start_goods`.`sequence` AS `sequence`,`net_start_goods`.`status` AS `status`,`goods`.`name` AS `name`,`net_start_goods`.`net_start_id` AS `net_start_id`,`goods`.`title_pic` AS `title_pic` from (`goods` join `net_start_goods` on((`net_start_goods`.`goodsid` = `goods`.`id`))) ;

-- ----------------------------
-- View structure for v_net_start_detail_view
-- ----------------------------
DROP VIEW IF EXISTS `v_net_start_detail_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_net_start_detail_view` AS select `net_start`.`id` AS `id`,`net_start`.`picurl_json` AS `picurl_json`,`net_start`.`name` AS `name`,`net_start`.`curr_activite_url` AS `curr_activite_url`,`net_start`.`curr_activite_start_time` AS `curr_activite_start_time`,`net_start`.`curr_activite_end_time` AS `curr_activite_end_time` from `net_start` ;

-- ----------------------------
-- View structure for v_net_start_goods_list
-- ----------------------------
DROP VIEW IF EXISTS `v_net_start_goods_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_net_start_goods_list` AS select `net_start_goods`.`id` AS `id`,`net_start_goods`.`net_start_id` AS `net_start_id`,`net_start_goods`.`goodsid` AS `goodsid`,`net_start_goods`.`history_price` AS `history_price`,`net_start_goods`.`sequence` AS `sequence`,`goods`.`name` AS `name`,`goods`.`title_pic` AS `title_pic`,`net_start_goods`.`status` AS `status` from (`net_start_goods` join `goods` on((`net_start_goods`.`goodsid` = `goods`.`id`))) ;

-- ----------------------------
-- View structure for v_net_stat_view
-- ----------------------------
DROP VIEW IF EXISTS `v_net_stat_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_net_stat_view` AS select `net_start`.`id` AS `id`,`net_start`.`picurl_json` AS `picurl_json`,`net_start`.`fans_count` AS `fans_count`,`net_start`.`goods_count` AS `goods_count`,`net_start`.`status` AS `status`,`net_start`.`curr_activite_start_time` AS `curr_activite_start_time`,`net_start`.`curr_activite_end_time` AS `curr_activite_end_time` from `net_start` ;

-- ----------------------------
-- View structure for v_new_old
-- ----------------------------
DROP VIEW IF EXISTS `v_new_old`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_new_old` AS select `goods`.`category` AS `category`,`goods`.`category_old` AS `category_old` from `goods` where ((`goods`.`category` is not null) and (`goods`.`category_old` is not null)) group by `goods`.`category`,`goods`.`category_old` ;

-- ----------------------------
-- View structure for v_order_balance
-- ----------------------------
DROP VIEW IF EXISTS `v_order_balance`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_order_balance` AS select `order_item`.`main_order_id` AS `main_order_id`,min(`order_item`.`is_balance`) AS `min_is_balance` from `order_item` group by `order_item`.`main_order_id` ;

-- ----------------------------
-- View structure for v_order_refund_apply_count
-- ----------------------------
DROP VIEW IF EXISTS `v_order_refund_apply_count`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_order_refund_apply_count` AS select `order_refund_apply`.`order_item_id` AS `order_item_id`,count(1) AS `count` from `order_refund_apply` where (`order_refund_apply`.`status` in (0,2)) group by `order_refund_apply`.`order_item_id` ;


-- ----------------------------
-- View structure for v_order_item_goods
-- ----------------------------
DROP VIEW IF EXISTS `v_order_item_goods`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_order_item_goods` AS select `goods`.`title_pic` AS `title_pic`,`order_item`.`id` AS `id`,`order_item`.`main_order_id` AS `main_order_id`,`goods`.`name` AS `goods_name`,`order_item`.`speci_id` AS `speci_id`,`order_item`.`status` AS `status_item`,`order_item`.`real_price` AS `real_price`,`order_item`.`amount` AS `amount`,`order_item`.`distributor_id` AS `distributor_id`,`order_item`.`activity_id` AS `activity_id`,`order_item`.`goodsid` AS `goodsid`,`order_item`.`sub_order_number` AS `sub_order_number`,`order_item`.`logistics_name` AS `logistics_name`,`order_item`.`logistics_number` AS `logistics_number`,`order_item`.`logistics_code` AS `logistics_code`,`order_item`.`comp_id` AS `comp_id`,`order_item`.`total_price` AS `total_price`,`order_item`.`discount_price` AS `discount_price`,`order_item`.`tran_price` AS `tran_price`,`order_item`.`activity_category` AS `activity_category`,`order_item`.`brokerage_id` AS `brokerage_id`,`order_item`.`is_balance` AS `is_balance`,`order_item`.`update_time` AS `update_time`,`order_item`.`pay_price` AS `pay_price`,`order_item`.`card_pay_price` AS `card_pay_price`,`order_item`.`create_time` AS `create_time`,`member`.`nickname` AS `nickname`,`member`.`realname` AS `realname`,`member`.`username` AS `username`,`talent`.`realname` AS `t_realname`,`order_item`.`speci_model1` AS `speci_model1`,`order_item`.`speci_model2` AS `speci_model2`,`order_item`.`speci_pic_url` AS `speci_pic_url`,`order_item`.`share_uid` AS `share_uid`,`v_order_refund_apply_count`.`count` AS `refund_count`,(case when isnull(`v_order_refund_price_new_status`.`status`) then `v_order_refund_apply_min_status`.`status` when isnull(`v_order_refund_apply_min_status`.`status`) then `v_order_refund_price_new_status`.`status` when (`v_order_refund_apply_min_status`.`status` > `v_order_refund_price_new_status`.`status`) then `v_order_refund_price_new_status`.`status` else `v_order_refund_apply_min_status`.`status` end) AS `refund_status`,(case when isnull(`v_order_refund_price_new_status`.`status`) then `v_order_refund_apply_min_status`.`status` when isnull(`v_order_refund_apply_min_status`.`status`) then `v_order_refund_price_new_status`.`status` when (`v_order_refund_apply_min_status`.`status` > `v_order_refund_price_new_status`.`status`) then `v_order_refund_price_new_status`.`status` else `v_order_refund_apply_min_status`.`status` end) AS `refund_show_status` from ((((((`order_item` join `goods` on((`order_item`.`goodsid` = `goods`.`id`))) left join `member` on((`order_item`.`distributor_id` = `member`.`id`))) left join `talent` on(((`member`.`id` = `talent`.`u_id`) and (`talent`.`status` in (3,4))))) left join `v_order_refund_apply_count` on((`order_item`.`id` = `v_order_refund_apply_count`.`order_item_id`))) left join `v_order_refund_price_new_status` on((`order_item`.`id` = `v_order_refund_price_new_status`.`order_item_id`))) left join `v_order_refund_apply_min_status` on((`order_item`.`id` = `v_order_refund_apply_min_status`.`order_item_id`))) where (`order_item`.`status` < 99) ;

-- ----------------------------
-- View structure for v_order_item_goods_all
-- ----------------------------
DROP VIEW IF EXISTS `v_order_item_goods_all`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_order_item_goods_all` AS select `goods`.`title_pic` AS `title_pic`,`order_item`.`id` AS `id`,`order_item`.`main_order_id` AS `main_order_id`,`goods`.`name` AS `goods_name`,`order_item`.`speci_id` AS `speci_id`,`order_item`.`status` AS `status_item`,`order_item`.`real_price` AS `real_price`,`order_item`.`amount` AS `amount`,`order_item`.`distributor_id` AS `distributor_id`,`order_item`.`activity_id` AS `activity_id`,`order_item`.`goodsid` AS `goodsid`,`order_item`.`sub_order_number` AS `sub_order_number`,`order_item`.`logistics_name` AS `logistics_name`,`order_item`.`logistics_number` AS `logistics_number`,`order_item`.`logistics_code` AS `logistics_code`,`order_item`.`comp_id` AS `comp_id`,`order_item`.`total_price` AS `total_price`,`order_item`.`discount_price` AS `discount_price`,`order_item`.`tran_price` AS `tran_price`,`order_item`.`activity_category` AS `activity_category`,`order_item`.`brokerage_id` AS `brokerage_id`,`order_item`.`is_balance` AS `is_balance`,`order_item`.`update_time` AS `update_time`,`order_item`.`pay_price` AS `pay_price`,`order_item`.`card_pay_price` AS `card_pay_price`,`order_item`.`create_time` AS `create_time`,`member`.`nickname` AS `nickname`,`member`.`realname` AS `realname`,`member`.`username` AS `username`,`talent`.`realname` AS `t_realname`,`order_item`.`speci_model1` AS `speci_model1`,`order_item`.`speci_model2` AS `speci_model2`,`order_item`.`speci_pic_url` AS `speci_pic_url`,(case when isnull(`v_order_refund_price_new_status`.`status`) then `v_order_refund_apply_min_status`.`status` when isnull(`v_order_refund_apply_min_status`.`status`) then `v_order_refund_price_new_status`.`status` when (`v_order_refund_apply_min_status`.`status` > `v_order_refund_price_new_status`.`status`) then `v_order_refund_price_new_status`.`status` else `v_order_refund_apply_min_status`.`status` end) AS `refund_show_status` from (((((`order_item` join `goods` on((`order_item`.`goodsid` = `goods`.`id`))) left join `member` on((`order_item`.`distributor_id` = `member`.`id`))) left join `talent` on(((`member`.`id` = `talent`.`u_id`) and (`talent`.`status` in (3,4))))) left join `v_order_refund_price_new_status` on((`order_item`.`id` = `v_order_refund_price_new_status`.`order_item_id`))) left join `v_order_refund_apply_min_status` on((`order_item`.`id` = `v_order_refund_apply_min_status`.`order_item_id`))) ;

-- ----------------------------
-- View structure for v_order_item_groupbuy
-- ----------------------------
DROP VIEW IF EXISTS `v_order_item_groupbuy`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_order_item_groupbuy` AS select `order_item`.`amount` AS `amount`,`order_item`.`status` AS `status`,`order_item`.`distributor_id` AS `distributor_id`,`order_item`.`activity_id` AS `activity_id`,`order_item`.`activity_category` AS `activity_category`,`group_buy`.`name` AS `name`,`group_buy`.`start_time` AS `start_time`,`group_buy`.`end_time` AS `end_time` from (`order_item` join `group_buy` on((`order_item`.`activity_id` = `group_buy`.`id`))) ;

-- ----------------------------
-- View structure for v_order_item_member
-- ----------------------------
DROP VIEW IF EXISTS `v_order_item_member`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_order_item_member` AS select `member`.`nickname` AS `nickname`,`member`.`picpath` AS `picpath`,`order_item`.`goodsid` AS `goodsid`,`member`.`level` AS `level`,`order_item`.`u_id` AS `u_id`,`order_item`.`id` AS `id`,`order_item`.`create_time` AS `create_time` from (`order_item` join `member` on((`order_item`.`u_id` = `member`.`id`))) ;

-- ----------------------------
-- View structure for v_order_item_today
-- ----------------------------
DROP VIEW IF EXISTS `v_order_item_today`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_order_item_today` AS select `order_item`.`id` AS `id`,`order_item`.`main_order_id` AS `main_order_id`,`order_item`.`pay_price` AS `sub_pay_price`,`order_item`.`total_price` AS `total_price`,`order_item`.`tran_price` AS `tran_price`,`order_item`.`activity_id` AS `activity_id`,`order_item`.`activity_category` AS `activity_category`,`order_item`.`goodsid` AS `goodsid`,`order_item`.`amount` AS `amount`,`order_item`.`speci_id` AS `speci_id`,`order_item`.`create_time` AS `create_time`,`order_item`.`status` AS `status`,`order_main`.`pay_time` AS `pay_time` from ((`order_item` join `order_main` on((`order_item`.`main_order_id` = `order_main`.`id`))) join `member` on(((`order_item`.`u_id` = `member`.`id`) and (`member`.`is_sd_user` = 0)))) where (`order_main`.`consumption_category` <> 5) ;

-- ----------------------------
-- View structure for v_order_main_item
-- ----------------------------
DROP VIEW IF EXISTS `v_order_main_item`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_order_main_item` AS select `order_item`.`id` AS `id`,`order_item`.`main_order_id` AS `main_order_id`,`order_main`.`vip_id_json` AS `vip_id_json`,`order_item`.`vip_id_json` AS `sub_vip_id_json`,`order_main`.`pay_price` AS `pay_price`,`order_item`.`pay_price` AS `sub_pay_price`,`order_main`.`card_pay_price` AS `card_pay_price`,`order_item`.`card_pay_price` AS `sub_card_pay_price`,`order_main`.`order_number` AS `order_number`,`order_item`.`distributor_id` AS `distributor_id`,`order_item`.`sub_order_number` AS `sub_order_number`,`order_item`.`total_price` AS `total_price`,`order_item`.`tran_price` AS `tran_price`,`order_item`.`activity_id` AS `activity_id`,`order_item`.`activity_category` AS `activity_category`,`order_item`.`goodsid` AS `goodsid`,`order_item`.`amount` AS `amount`,`order_main`.`ticket_id` AS `ticket_id`,`order_item`.`speci_id` AS `speci_id`,`order_main`.`status` AS `status` from (`order_main` join `order_item` on((`order_item`.`main_order_id` = `order_main`.`id`))) ;


-- ----------------------------
-- View structure for v_order_main_search
-- ----------------------------
DROP VIEW IF EXISTS `v_order_main_search`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_order_main_search` AS select `order_item`.`sub_order_number` AS `sub_order_number`,`member`.`username` AS `username`,`t_member`.`nickname` AS `t_nickname`,`t_member`.`realname` AS `t_realname`,`goods_brand`.`name` AS `brand_name`,`order_main`.`id` AS `id`,`order_main`.`order_number` AS `order_number`,`order_main`.`u_id` AS `u_id`,`order_main`.`consumption_category` AS `consumption_category`,`order_main`.`status` AS `status`,`order_main`.`amount` AS `amount`,`order_main`.`pay_price` AS `pay_price`,`order_main`.`create_time` AS `create_time`,`order_main`.`pay_time` AS `pay_time`,`order_main`.`pay_category` AS `pay_category`,`order_main`.`remark` AS `remark`,`order_main`.`address_id` AS `address_id`,`order_main`.`city_name` AS `city_name`,`order_main`.`zone_name` AS `zone_name`,`order_main`.`recv_name` AS `recv_name`,`order_main`.`recv_phone` AS `recv_phone`,`order_main`.`address` AS `address`,`order_main`.`is_address_modify` AS `is_address_modify`,`order_main`.`ticket_id` AS `ticket_id`,`order_main`.`distributor_json` AS `distributor_json`,`order_main`.`total_price` AS `total_price`,`order_main`.`tran_price` AS `tran_price`,`order_main`.`discount_price` AS `discount_price`,`order_main`.`running_number` AS `running_number`,`order_main`.`wechat_number` AS `wechat_number`,`t_member`.`username` AS `t_username`,concat(convert(`order_main`.`order_number` using utf8mb4),'|',convert(`order_item`.`sub_order_number` using utf8mb4),'|',`order_main`.`u_id`,'|',ifnull(`t_member`.`username`,''),'|',ifnull(`t_member`.`nickname`,''),'|',convert(ifnull(`t_member`.`realname`,'') using utf8mb4),'|',convert(`goods_brand`.`name` using utf8mb4),'|',convert(`order_item`.`name` using utf8mb4),'|',convert(ifnull(`order_item`.`code`,'') using utf8mb4),'|',`member`.`username`,'|',convert(`order_main`.`recv_name` using utf8mb4),'|',convert(`order_main`.`recv_phone` using utf8mb4),'|',convert(`order_main`.`province_name` using utf8mb4),convert(`order_main`.`city_name` using utf8mb4),convert(`order_main`.`zone_name` using utf8mb4),convert(`order_main`.`address` using utf8mb4),'|',convert(ifnull(`order_item`.`logistics_name`,'') using utf8mb4),'|',convert(ifnull(`order_item`.`logistics_number`,'') using utf8mb4)) AS `searchVal`,`order_main`.`vip_id_json` AS `vip_id_json`,`order_main`.`card_pay_price` AS `card_pay_price`,`order_main`.`update_time` AS `update_time`,`order_item`.`status` AS `sub_status`,`order_item`.`activity_category` AS `activity_category`,`order_refund_price`.`status` AS `apply_status`,`order_item`.`id` AS `sub_id`,`company`.`name` AS `comp_name`,`order_item`.`speci_model1` AS `speci_model1`,`order_item`.`speci_model2` AS `speci_model2`,`order_item`.`speci_id` AS `speci_id`,`order_main`.`ticket_price` AS `ticket_price`,`order_item`.`tran_price` AS `sub_tran_price`,`order_item`.`amount` AS `sub_amount`,`order_item`.`total_price` AS `sub_total_price`,`order_item`.`pay_price` AS `sub_pay_price`,`order_item`.`card_pay_price` AS `sub_card_pay_price`,`order_main`.`province_name` AS `province_name`,`order_main`.`remark_admin` AS `remark_admin`,`order_item`.`logistics_name` AS `logistics_name`,`order_item`.`logistics_number` AS `logistics_number`,`order_item`.`vip_id_json` AS `sub_vip_id_json`,`order_item`.`discount_price` AS `sub_discount_price`,`member`.`realname` AS `realname`,`member`.`cardnum` AS `cardnum`,`order_item`.`is_balance` AS `sub_is_balance`,`order_item`.`trade_send` AS `trade_send`,`order_item`.`sale_price` AS `sale_price`,`order_item`.`stock_price` AS `stock_price`,`order_item`.`code` AS `code`,`order_item`.`name` AS `name`,`order_item`.`real_price` AS `real_price`,`order_item`.`brand` AS `brand`,`order_refund_price`.`refund_price` AS `refund_price`,`order_refund_price`.`reason` AS `reason`,`order_item`.`distributor_id` AS `distributor_id`,`order_item`.`brokerage_type` AS `brokerage_type`,`order_item`.`brokerage_rate` AS `brokerage_rate`,`order_item`.`brokerage_price` AS `brokerage_price`,`order_refund_price`.`remark` AS `refund_remark`,`order_item`.`comp_id` AS `comp_id`,`order_item`.`points` AS `points`,`order_main`.`alipay_number` AS `alipay_number`,`t_member`.`is_sd_user` AS `is_sd_user`,`v_order_balance`.`min_is_balance` AS `is_balance`,`v_order_main_refund_status`.`refund_status` AS `refund_status`,(case when isnull(`v_order_main_refund_status`.`refund_status`) then `v_order_refund_apply_min_status`.`status` when isnull(`v_order_refund_apply_min_status`.`status`) then `v_order_main_refund_status`.`refund_status` when (`v_order_refund_apply_min_status`.`status` > `v_order_main_refund_status`.`refund_status`) then `v_order_main_refund_status`.`refund_status` else `v_order_refund_apply_min_status`.`status` end) AS `refund_show_status` from (((((((((`order_main` join `order_item` on((`order_main`.`id` = `order_item`.`main_order_id`))) join `member` on((`order_main`.`u_id` = `member`.`id`))) join `goods_brand` on((`order_item`.`brand` = `goods_brand`.`id`))) left join `member` `t_member` on((`order_item`.`distributor_id` = `t_member`.`id`))) left join `order_refund_price` on((`order_item`.`id` = `order_refund_price`.`order_item_id`))) join `company` on((`order_item`.`comp_id` = `company`.`id`))) join `v_order_balance` on((`v_order_balance`.`main_order_id` = `order_main`.`id`))) left join `v_order_main_refund_status` on((`order_main`.`order_number` = `v_order_main_refund_status`.`order_main_number`))) left join `v_order_refund_apply_min_status` on((`order_main`.`order_number` = `v_order_refund_apply_min_status`.`order_main_number`))) ;

-- ----------------------------
-- View structure for v_order_main_search_copy
-- ----------------------------
DROP VIEW IF EXISTS `v_order_main_search_copy`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_order_main_search_copy` AS select `order_main`.`id` AS `id`,`order_main`.`create_time` AS `create_time` from ((((((`order_main` join `order_item` on((`order_main`.`id` = `order_item`.`main_order_id`))) join `member` on((`order_main`.`u_id` = `member`.`id`))) join `goods_brand` on((`order_item`.`brand` = `goods_brand`.`id`))) left join `member` `t_member` on((`order_item`.`distributor_id` = `t_member`.`id`))) left join `order_refund_price` on((`order_item`.`id` = `order_refund_price`.`order_item_id`))) join `company` on((`order_item`.`comp_id` = `company`.`id`))) ;


-- ----------------------------
-- View structure for v_order_main_today
-- ----------------------------
DROP VIEW IF EXISTS `v_order_main_today`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_order_main_today` AS select `order_main`.`id` AS `id`,`order_main`.`status` AS `status`,`order_main`.`amount` AS `amount`,`order_main`.`pay_price` AS `pay_price`,`order_main`.`total_price` AS `total_price`,`order_main`.`tran_price` AS `tran_price`,`order_main`.`create_time` AS `create_time`,`order_main`.`consumption_category` AS `consumption_category` from (`order_main` join `member` on(((`order_main`.`u_id` = `member`.`id`) and (`member`.`is_sd_user` = 0)))) where (`order_main`.`consumption_category` <> 5) ;

-- ----------------------------
-- View structure for v_order_manager_list
-- ----------------------------
DROP VIEW IF EXISTS `v_order_manager_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_order_manager_list` AS select `order_item`.`status` AS `sub_status`,`order_main`.`order_number` AS `order_number`,`order_main`.`id` AS `id`,`order_main`.`u_id` AS `u_id`,`order_main`.`consumption_category` AS `consumption_category`,`order_main`.`status` AS `status`,`order_main`.`amount` AS `amount`,`order_main`.`pay_price` AS `pay_price`,`order_main`.`pay_time` AS `pay_time`,`order_main`.`pay_category` AS `pay_category`,`order_main`.`remark` AS `remark`,`order_main`.`address_id` AS `address_id`,`order_main`.`province_name` AS `province_name`,`order_main`.`city_name` AS `city_name`,`order_main`.`zone_name` AS `zone_name`,`order_main`.`recv_name` AS `recv_name`,`order_main`.`recv_phone` AS `recv_phone`,`order_main`.`address` AS `address`,`order_main`.`is_address_modify` AS `is_address_modify`,`order_main`.`ticket_id` AS `ticket_id`,`order_main`.`vip_id_json` AS `vip_id_json`,`order_main`.`card_pay_price` AS `card_pay_price`,`order_main`.`distributor_json` AS `distributor_json`,`order_main`.`total_price` AS `total_price`,`order_main`.`tran_price` AS `tran_price`,`order_main`.`discount_price` AS `discount_price`,`order_main`.`is_balance` AS `is_balance`,`order_main`.`running_number` AS `running_number`,`order_main`.`wechat_number` AS `wechat_number`,`order_main`.`create_time` AS `create_time`,`order_main`.`update_time` AS `update_time`,`order_item`.`activity_category` AS `activity_category`,`order_main`.`remark_admin` AS `remark_admin`,`order_item`.`comp_id` AS `comp_id`,`member`.`is_sd_user` AS `is_sd_user`,`v_order_main_refund_status`.`refund_status` AS `refund_status`,(case when isnull(`v_order_main_refund_status`.`refund_status`) then `v_order_refund_apply_min_status`.`status` when isnull(`v_order_refund_apply_min_status`.`status`) then `v_order_main_refund_status`.`refund_status` when (`v_order_refund_apply_min_status`.`status` > `v_order_main_refund_status`.`refund_status`) then `v_order_main_refund_status`.`refund_status` else `v_order_refund_apply_min_status`.`status` end) AS `refund_show_status` from ((((`order_main` join `order_item` on((`order_main`.`id` = `order_item`.`main_order_id`))) join `member` on((`member`.`id` = `order_item`.`u_id`))) left join `v_order_main_refund_status` on((`order_main`.`order_number` = `v_order_main_refund_status`.`order_main_number`))) left join `v_order_refund_apply_min_status` on((`order_main`.`order_number` = `v_order_refund_apply_min_status`.`order_main_number`))) ;

-- ----------------------------
-- View structure for v_order_refund_apply
-- ----------------------------
DROP VIEW IF EXISTS `v_order_refund_apply`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_order_refund_apply` AS select `order_refund_apply`.`id` AS `id`,`order_refund_apply`.`order_main_number` AS `order_main_number`,`order_refund_apply`.`order_item_number` AS `order_item_number`,`order_refund_apply`.`order_item_id` AS `order_item_id`,`order_refund_apply`.`goods_id` AS `goods_id`,`order_refund_apply`.`order_pay_price` AS `order_pay_price`,`order_refund_apply`.`refund_type` AS `refund_type`,`order_refund_apply`.`refund_reason_id` AS `refund_reason_id`,`order_refund_apply`.`remark` AS `remark`,`order_refund_apply`.`status` AS `status`,`order_refund_apply`.`create_time` AS `create_time`,`order_refund_apply`.`check_remark` AS `check_remark`,`order_refund_apply`.`check_time` AS `check_time`,`order_refund_apply`.`pic_list_json` AS `pic_list_json`,`member`.`username` AS `username`,`member`.`nickname` AS `nickname`,`member`.`realname` AS `realname`,`order_refund_reason`.`title` AS `title`,`order_refund_reason`.`remark` AS `refundReasonRemark`,`order_item`.`activity_category` AS `activity_category` from (((`member` join `order_refund_apply` on((`order_refund_apply`.`u_id` = `member`.`id`))) join `order_refund_reason` on((`order_refund_apply`.`refund_reason_id` = `order_refund_reason`.`id`))) join `order_item` on((`order_refund_apply`.`order_item_id` = `order_item`.`id`))) ;

-- ----------------------------
-- View structure for v_pc_goods
-- ----------------------------
DROP VIEW IF EXISTS `v_pc_goods`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_pc_goods` AS select `goods`.`id` AS `id`,`goods`.`name` AS `name`,`goods`.`code` AS `code`,`goods`.`comp_id` AS `comp_id`,`goods`.`title_pic` AS `title_pic`,`goods`.`banner_json` AS `banner_json`,`goods`.`details_json` AS `details_json`,`goods`.`brand` AS `brand`,`goods`.`category` AS `category`,`goods`.`start_time` AS `start_time`,`goods`.`end_time` AS `end_time`,`goods`.`speci_json` AS `speci_json`,`goods`.`amount` AS `amount`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price`,`goods`.`delivery` AS `delivery`,`goods`.`send_hour` AS `send_hour`,`goods`.`safeguard_json` AS `safeguard_json`,`goods`.`activity_json` AS `activity_json`,`goods`.`hot_sell` AS `hot_sell`,`goods`.`less_stock` AS `less_stock`,`goods`.`trade_send` AS `trade_send`,`goods`.`status` AS `status`,`goods`.`sale_count` AS `sale_count`,`goods`.`base_sale_count` AS `base_sale_count`,`goods`.`report_count` AS `report_count`,`goods`.`collection_count` AS `collection_count`,`goods`.`remind_count` AS `remind_count`,`goods`.`view_count` AS `view_count`,`goods`.`u_id` AS `u_id`,`goods`.`create_time` AS `create_time`,`goods`.`update_time` AS `update_time`,`goods`.`base_collection_count` AS `base_collection_count`,`goods`.`gid` AS `gid`,`goods`.`auto_inc_id` AS `auto_inc_id`,`goods`.`sequence` AS `sequence` from `goods` ;

-- ----------------------------
-- View structure for v_points_mall_goods_view
-- ----------------------------
DROP VIEW IF EXISTS `v_points_mall_goods_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_points_mall_goods_view` AS select `points_mall_goods`.`id` AS `id`,`points_mall_goods`.`ticket_id` AS `ticket_id`,`points_mall_goods`.`points` AS `points`,`points_mall_goods`.`start_time` AS `start_time`,`points_mall_goods`.`end_time` AS `end_time`,`points_mall_goods`.`status` AS `status`,`ticket`.`type` AS `type`,`ticket`.`name` AS `name`,`ticket`.`picurl` AS `picurl`,`ticket`.`full_price` AS `full_price`,`ticket`.`price` AS `price`,`ticket`.`remark` AS `remark`,`ticket`.`is_show` AS `is_show` from (`points_mall_goods` join `ticket` on((`points_mall_goods`.`ticket_id` = `ticket`.`id`))) ;

-- ----------------------------
-- View structure for v_recommend_goods
-- ----------------------------
DROP VIEW IF EXISTS `v_recommend_goods`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_recommend_goods` AS select `recommend`.`id` AS `id`,`recommend`.`goodsid` AS `goodsid`,`goods`.`name` AS `name`,`goods`.`title_pic` AS `title_pic`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price`,`goods`.`sale_count` AS `sale_count`,`goods`.`base_sale_count` AS `base_sale_count` from (`recommend` join `goods` on((`recommend`.`goodsid` = `goods`.`id`))) ;

-- ----------------------------
-- View structure for v_shopping_cart_count
-- ----------------------------
DROP VIEW IF EXISTS `v_shopping_cart_count`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_shopping_cart_count` AS select sum(`shopping_cart`.`amount`) AS `count`,`shopping_cart`.`u_id` AS `u_id` from `shopping_cart` group by `shopping_cart`.`u_id` ;

-- ----------------------------
-- View structure for v_shoppingcart_list
-- ----------------------------
DROP VIEW IF EXISTS `v_shoppingcart_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_shoppingcart_list` AS select `shopping_cart`.`id` AS `id`,`shopping_cart`.`u_id` AS `u_id`,`shopping_cart`.`goods_id` AS `goods_id`,`shopping_cart`.`speci_id` AS `speci_id`,`shopping_cart`.`amount` AS `amount`,`shopping_cart`.`status` AS `status`,`shopping_cart`.`create_time` AS `create_time`,`shopping_cart`.`update_time` AS `update_time`,`goods`.`name` AS `goods_name`,`goods`.`title_pic` AS `title_pic`,`goods`.`speci_json` AS `speci_json`,`goods`.`activity_json` AS `activity_json`,`goods`.`category` AS `category`,`goods`.`status` AS `goods_status`,`goods`.`trade_send` AS `trade_send`,`shopping_cart`.`headstrong` AS `headstrong` from (`shopping_cart` join `goods` on(((`shopping_cart`.`goods_id` = `goods`.`id`) and (`shopping_cart`.`status` = 1)))) ;

-- ----------------------------
-- View structure for v_special_column
-- ----------------------------
DROP VIEW IF EXISTS `v_special_column`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_special_column` AS select `main_cfg_special_column`.`id` AS `id`,`main_cfg_special_column`.`uid` AS `uid`,`main_cfg_special_column`.`content` AS `content`,`main_cfg_special_column`.`picpath` AS `picpath`,`main_cfg_special_column`.`status` AS `status`,`member`.`nickname` AS `nickname`,`member`.`picpath` AS `member_picpath`,`member`.`feeling` AS `feeling` from (`member` join `main_cfg_special_column` on((`member`.`id` = `main_cfg_special_column`.`uid`))) ;

-- ----------------------------
-- View structure for v_subject_goods_list
-- ----------------------------
DROP VIEW IF EXISTS `v_subject_goods_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_subject_goods_list` AS select `subject_goods`.`id` AS `id`,`subject_goods`.`subject_id` AS `subject_id`,`subject_goods`.`goodsid` AS `goodsid`,`subject_goods`.`sequence` AS `sequence`,`subject_goods`.`status` AS `status`,`goods`.`name` AS `name`,`goods`.`title_pic` AS `title_pic`,`goods`.`price` AS `price`,`goods`.`activity_json` AS `activity_json`,`goods`.`sale_count` AS `sale_count`,`goods`.`base_sale_count` AS `base_sale_count`,`goods`.`sale_price` AS `sale_price`,`goods`.`status` AS `goods_status` from (`subject_goods` join `goods` on(((`subject_goods`.`goodsid` = `goods`.`id`) and (`goods`.`status` = 3)))) where (`goods`.`status` = 3) ;

-- ----------------------------
-- View structure for v_talent_bank_record_list
-- ----------------------------
DROP VIEW IF EXISTS `v_talent_bank_record_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_talent_bank_record_list` AS select `talent_bank_record`.`id` AS `id`,`talent_bank_record`.`bank_id` AS `bank_id`,`talent_bank_record`.`bank_num` AS `bank_num`,`talent_bank_record`.`bank_user_name` AS `bank_user_name`,`talent_bank_record`.`order_item_id` AS `order_item_id`,`talent_bank_record`.`order_price` AS `order_price`,`talent_bank_record`.`brokerage_type` AS `brokerage_type`,`talent_bank_record`.`brokerage_price` AS `brokerage_price`,`talent_bank_record`.`price` AS `price`,`talent_bank_record`.`create_time` AS `create_time`,`talent_bank_record`.`type` AS `type`,`talent_bank_record`.`status` AS `status`,`talent`.`realname` AS `realname`,`talent`.`id_card` AS `id_card`,`talent`.`phone` AS `phone`,`talent`.`we_char` AS `we_char`,`talent`.`qq` AS `qq`,`talent_bank_record`.`u_id` AS `u_id`,`talent_bank`.`card_num` AS `card_num`,`talent_bank`.`bank_name` AS `bank_name`,`talent_bank`.`real_name` AS `real_name`,`talent_bank`.`remark` AS `remark`,`talent_bank_record`.`order_item_number` AS `order_item_number`,`talent`.`status` AS `t_status`,`member`.`nickname` AS `nickname`,`talent`.`get_price_all` AS `get_price_all` from (((`talent_bank_record` join `talent` on((`talent_bank_record`.`u_id` = `talent`.`u_id`))) join `talent_bank` on((`talent_bank`.`id` = `talent_bank_record`.`bank_id`))) join `member` on((`talent_bank_record`.`u_id` = `member`.`id`))) where (`talent`.`status` = 3) ;

-- ----------------------------
-- View structure for v_talent_brokerage_detail
-- ----------------------------
DROP VIEW IF EXISTS `v_talent_brokerage_detail`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_talent_brokerage_detail` AS select `talent_bank_record`.`type` AS `type`,`talent_bank_record`.`create_time` AS `create_time`,`talent_bank_record`.`price` AS `price`,`talent_bank_record`.`brokerage_price` AS `brokerage_price`,`talent_bank_record`.`brokerage_type` AS `brokerage_type`,`talent_bank_record`.`order_price` AS `order_price`,`talent_bank_record`.`order_item_id` AS `order_item_id`,`goods`.`name` AS `name`,`talent_bank_record`.`order_goods_count` AS `order_goods_count`,`talent_bank_record`.`u_id` AS `u_id`,`talent_bank_record`.`order_item_number` AS `order_item_number`,`talent_bank_record`.`has_sended` AS `has_sended` from (`goods` join `talent_bank_record` on((`talent_bank_record`.`goodsid` = `goods`.`id`))) where (`talent_bank_record`.`has_sended` = 1) ;

-- ----------------------------
-- View structure for v_talent_brokerage_list
-- ----------------------------
DROP VIEW IF EXISTS `v_talent_brokerage_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_talent_brokerage_list` AS select `talent`.`phone` AS `phone`,`talent`.`id_card` AS `id_card`,`talent`.`u_id` AS `u_id`,`talent`.`realname` AS `realname`,`member`.`nickname` AS `nickname`,`talent`.`status` AS `status` from (`talent` join `member` on((`talent`.`u_id` = `member`.`id`))) where ((`talent`.`status` = 3) and `talent`.`u_id` in (select `talent_bank_record`.`u_id` from `talent_bank_record` group by `talent_bank_record`.`u_id`)) ;

-- ----------------------------
-- View structure for v_talent_fans_list
-- ----------------------------
DROP VIEW IF EXISTS `v_talent_fans_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_talent_fans_list` AS select `fans_like_talent`.`id` AS `id`,`fans_like_talent`.`fansid` AS `fansid`,`fans_like_talent`.`talentid` AS `talentid`,`fans_like_talent`.`status` AS `status`,`member`.`nickname` AS `nickname`,`member`.`picpath` AS `picpath`,`member`.`level` AS `level`,`member`.`feeling` AS `feeling` from (`fans_like_talent` join `member` on((`fans_like_talent`.`fansid` = `member`.`id`))) ;

-- ----------------------------
-- View structure for v_talent_group_buy_list
-- ----------------------------
DROP VIEW IF EXISTS `v_talent_group_buy_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_talent_group_buy_list` AS select `group_buy`.`name` AS `name`,`group_buy`.`small_price` AS `small_price`,`group_buy`.`sale_price` AS `sale_price`,`group_buy`.`sale_count` AS `sale_count`,`group_buy`.`status` AS `group_status`,`talent_group_buy_record`.`talentid` AS `talentid`,`group_buy`.`goodsid` AS `goodsid`,`group_buy`.`sequence` AS `sequence`,`talent_group_buy_record`.`status` AS `talent_group_status`,`talent_group_buy_record`.`groupbuyid` AS `groupbuyid`,`talent_group_buy_record`.`id` AS `id`,`group_buy`.`picpath` AS `picpath`,`group_buy`.`start_time` AS `start_time`,`group_buy`.`end_time` AS `end_time` from (`talent_group_buy_record` join `group_buy` on((`talent_group_buy_record`.`groupbuyid` = `group_buy`.`id`))) ;

-- ----------------------------
-- View structure for v_talent_group_buy_recommend_info
-- ----------------------------
DROP VIEW IF EXISTS `v_talent_group_buy_recommend_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_talent_group_buy_recommend_info` AS select `talent_group_buy_record`.`id` AS `id`,`member`.`level` AS `level`,`member`.`picpath` AS `picpath`,`talent_group_buy_record`.`content` AS `content`,`talent_group_buy_record`.`status` AS `status`,`talent_group_buy_record`.`talentid` AS `talentid`,`member`.`nickname` AS `nickname`,`talent_group_buy_record`.`groupbuyid` AS `groupbuyid` from (`member` join `talent_group_buy_record` on(((`member`.`id` = `talent_group_buy_record`.`talentid`) and (`talent_group_buy_record`.`status` = 2)))) ;

-- ----------------------------
-- View structure for v_talent_group_buy_record_list
-- ----------------------------
DROP VIEW IF EXISTS `v_talent_group_buy_record_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_talent_group_buy_record_list` AS select `talent_group_buy_record`.`id` AS `id`,`talent_group_buy_record`.`talentid` AS `talentid`,`talent_group_buy_record`.`create_time` AS `create_time`,`talent_group_buy_record`.`content` AS `content`,`talent_group_buy_record`.`status` AS `status`,`talent_group_buy_record`.`refuse_reason` AS `refuse_reason`,`talent_group_buy_record`.`pass_time` AS `pass_time`,`talent_group_buy_record`.`sale_count` AS `sale_count`,`group_buy`.`name` AS `name`,`group_buy`.`start_time` AS `start_time`,`group_buy`.`end_time` AS `end_time`,`group_buy`.`small_price` AS `small_price`,`group_buy`.`brokerage_type` AS `brokerage_type`,`group_buy`.`brokerage_price` AS `brokerage_price`,`member`.`nickname` AS `nickname`,`member`.`level` AS `level`,`member`.`username` AS `username`,`group_buy`.`picpath` AS `picpath`,`group_buy`.`category` AS `category`,`group_buy`.`status` AS `gbstatus`,`group_buy`.`sale_price` AS `sale_price`,`group_buy`.`speci_json` AS `speci_json`,`group_buy`.`goodsid` AS `goodsid`,`group_buy`.`sale_count` AS `sale_count_group`,`group_buy`.`status` AS `status_group`,`talent_group_buy_record`.`groupbuyid` AS `groupbuyid`,`talent_group_buy_record`.`show_ctx` AS `show_ctx`,`member`.`picpath` AS `head_pic`,`goods`.`sale_count` AS `goods_sale_count`,`goods`.`base_sale_count` AS `goods_base_sale_count`,`goods`.`status` AS `goods_status`,`group_buy`.`base_sale_count` AS `base_sale_count`,`member`.`feeling` AS `feeling`,(case when (`group_buy`.`status` > 4) then 5 when (`group_buy`.`status` = 4) then 4 when ((`group_buy`.`start_time` < now()) and (`group_buy`.`end_time` > now())) then 1 when (`group_buy`.`start_time` > now()) then 2 else 3 end) AS `st` from (((`talent_group_buy_record` join `group_buy` on((`talent_group_buy_record`.`groupbuyid` = `group_buy`.`id`))) join `member` on((`talent_group_buy_record`.`talentid` = `member`.`id`))) join `goods` on((`goods`.`id` = `group_buy`.`goodsid`))) ;

-- ----------------------------
-- View structure for v_talent_group_member
-- ----------------------------
DROP VIEW IF EXISTS `v_talent_group_member`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_talent_group_member` AS select `member`.`nickname` AS `nickname`,`member`.`picpath` AS `picpath`,`member`.`level` AS `level`,`member`.`id` AS `id`,`talent_group_buy_record`.`groupbuyid` AS `groupbuyid`,`talent_group_buy_record`.`status` AS `status`,`talent_group_buy_record`.`show_ctx` AS `show_ctx`,`talent_group_buy_record`.`content` AS `content`,`talent_group_buy_record`.`talentid` AS `talentid` from ((`member` join `talent` on((`talent`.`u_id` = `member`.`id`))) join `talent_group_buy_record` on((`talent`.`u_id` = `talent_group_buy_record`.`talentid`))) ;

-- ----------------------------
-- View structure for v_talent_group_order_list
-- ----------------------------
DROP VIEW IF EXISTS `v_talent_group_order_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_talent_group_order_list` AS select `order_item`.`activity_id` AS `groupbuyid`,`order_item`.`activity_category` AS `activity_category`,`order_item`.`distributor_id` AS `talentid`,`order_main`.`amount` AS `amount`,`order_item`.`main_order_id` AS `main_order_id`,`order_item`.`id` AS `id`,`order_main`.`order_number` AS `order_number`,`order_main`.`create_time` AS `create_time`,`order_main`.`status` AS `status`,`order_main`.`distributor_json` AS `distributor_json` from (`order_main` join `order_item` on((`order_main`.`id` = `order_item`.`main_order_id`))) where ((`order_main`.`distributor_json` is not null) and (`order_item`.`activity_category` = 1)) ;

-- ----------------------------
-- View structure for v_talent_import
-- ----------------------------
DROP VIEW IF EXISTS `v_talent_import`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_talent_import` AS select `talent_import_fans`.`talentid` AS `talentid`,`talent`.`realname` AS `realname`,`talent_import_fans`.`create_time` AS `create_time`,`member`.`username` AS `username`,`member`.`nickname` AS `nickname` from ((`talent_import_fans` join `member` on((`talent_import_fans`.`talentid` = `member`.`id`))) join `talent` on(((`member`.`id` = `talent`.`u_id`) and (`talent`.`status` = 3)))) ;

-- ----------------------------
-- View structure for v_talent_import_fans
-- ----------------------------
DROP VIEW IF EXISTS `v_talent_import_fans`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_talent_import_fans` AS select `talent_import_fans`.`talentid` AS `talentid`,`talent_import_fans`.`id` AS `id`,`talent_import_fans`.`fansid` AS `fansid`,`talent_import_fans`.`goodsid` AS `goodsid`,`talent_import_fans`.`create_time` AS `create_time`,`talent_import_fans`.`status` AS `status`,`member`.`nickname` AS `nickname`,`member`.`picpath` AS `picpath`,`member`.`level` AS `level`,`talent`.`get_price_all` AS `get_price_all`,`talent`.`groupbuy_get_count` AS `groupbuy_get_count` from ((`talent_import_fans` join `member` on((`talent_import_fans`.`fansid` = `member`.`id`))) left join `talent` on(((`talent`.`u_id` = `member`.`id`) and (`talent`.`status` = 3)))) ;

-- ----------------------------
-- View structure for v_talent_import_st
-- ----------------------------
DROP VIEW IF EXISTS `v_talent_import_st`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_talent_import_st` AS select `talent_import_fans`.`talentid` AS `talentid`,`talent_import_fans`.`create_time` AS `create_time`,`talent`.`realname` AS `realname`,`member`.`level` AS `level`,`talent_import_fans`.`fansid` AS `fansid`,`member`.`username` AS `username` from ((`talent_import_fans` join `member` on((`talent_import_fans`.`fansid` = `member`.`id`))) join `talent` on((`talent_import_fans`.`talentid` = `talent`.`u_id`))) ;

-- ----------------------------
-- View structure for v_talent_maininfo
-- ----------------------------
DROP VIEW IF EXISTS `v_talent_maininfo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_talent_maininfo` AS select `member`.`nickname` AS `nickname`,`member`.`picpath` AS `picpath`,`member`.`feeling` AS `feeling`,`talent`.`id` AS `id`,`talent`.`level` AS `level`,`talent`.`u_id` AS `u_id`,`talent`.`back_pic` AS `back_pic`,`talent`.`status` AS `status`,`member`.`fans_like_count` AS `fans_like_count`,`talent`.`has_new_fee` AS `has_new_fee`,`talent`.`has_new_order` AS `has_new_order`,`talent`.`has_new_import` AS `has_new_import` from (`member` join `talent` on((`talent`.`u_id` = `member`.`id`))) ;

-- ----------------------------
-- View structure for v_talent_order_list_show_act
-- ----------------------------
DROP VIEW IF EXISTS `v_talent_order_list_show_act`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_talent_order_list_show_act` AS select `order_item`.`activity_id` AS `groupbuyid`,`order_item`.`activity_category` AS `activity_category`,`order_item`.`distributor_id` AS `talentid`,`order_main`.`amount` AS `amount`,`order_item`.`main_order_id` AS `main_order_id`,`order_item`.`id` AS `id`,`order_main`.`order_number` AS `order_number`,`order_main`.`create_time` AS `create_time`,`order_main`.`status` AS `status`,`order_main`.`pay_time` AS `pay_time`,`order_item`.`goodsid` AS `goodsid`,`order_item`.`share_uid` AS `share_uid` from ((`order_main` join `order_item` on((`order_main`.`id` = `order_item`.`main_order_id`))) join `talent_show_act_order_cfg` on((`order_item`.`share_uid` = `talent_show_act_order_cfg`.`talent_id`))) where (`order_main`.`status` <> 99) ;

-- ----------------------------
-- View structure for v_talent_st
-- ----------------------------
DROP VIEW IF EXISTS `v_talent_st`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_talent_st` AS select `t1`.`create_time` AS `create_time`,`t1`.`realname` AS `realname`,`t1`.`status` AS `status`,`talent_import_fans`.`talentid` AS `talentid`,`talent_import_fans`.`fansid` AS `fansid`,`member`.`realname` AS `import_name` from ((`talent` `t1` left join `talent_import_fans` on((`t1`.`u_id` = `talent_import_fans`.`fansid`))) left join `member` on((`talent_import_fans`.`talentid` = `member`.`id`))) ;

-- ----------------------------
-- View structure for v_talent_statistics
-- ----------------------------
DROP VIEW IF EXISTS `v_talent_statistics`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_talent_statistics` AS select `talent`.`u_id` AS `u_id`,`member`.`id` AS `id`,`talent`.`id` AS `talentid`,`member`.`level` AS `level`,`talent`.`realname` AS `realname` from (`member` join `talent` on((`talent`.`u_id` = `member`.`id`))) where (`talent`.`status` = 3) ;

-- ----------------------------
-- View structure for v_talentInfo
-- ----------------------------
DROP VIEW IF EXISTS `v_talentInfo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_talentInfo` AS select `talent`.`level` AS `level`,`talent`.`u_id` AS `u_id`,`talent`.`back_pic` AS `back_pic`,`member`.`nickname` AS `nickname`,`member`.`picpath` AS `picpath`,`talent`.`status` AS `status`,`talent`.`id` AS `id`,`talent`.`phone` AS `phone`,`talent`.`qq` AS `qq`,`talent`.`we_char` AS `we_char`,`talent`.`realname` AS `realname`,`member`.`cardnum` AS `cardnum`,`talent`.`is_stay_moom` AS `is_stay_moom`,`talent`.`is_has_baby` AS `is_has_baby`,`talent`.`remark` AS `remark`,`member`.`feeling` AS `feeling`,`talent`.`refuse_reason` AS `refuse_reason`,`talent`.`create_time` AS `create_time`,`talent`.`pass_time` AS `pass_time`,`talent`.`id_card` AS `id_card`,`member`.`fans_like_count` AS `fans_like_count`,`talent`.`reason` AS `reason`,`talent`.`is_group_seller` AS `is_group_seller` from (`talent` join `member` on((`member`.`id` = `talent`.`u_id`))) ;

-- ----------------------------
-- View structure for v_today_new
-- ----------------------------
DROP VIEW IF EXISTS `v_today_new`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_today_new` AS select `today_new`.`id` AS `id`,`today_new`.`goodsid` AS `goodsid`,`today_new`.`sequence` AS `sequence`,`today_new`.`status` AS `status`,`today_new`.`create_time` AS `create_time`,`goods`.`name` AS `name`,`goods`.`title_pic` AS `title_pic`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price`,`goods`.`sale_count` AS `sale_count`,`goods`.`base_sale_count` AS `base_sale_count`,`goods`.`activity_json` AS `activity_json`,`goods`.`status` AS `gstatus` from (`today_new` join `goods` on(((`today_new`.`goodsid` = `goods`.`id`) and (`today_new`.`status` < 99)))) ;

-- ----------------------------
-- View structure for v_tryout_apply_auth
-- ----------------------------
DROP VIEW IF EXISTS `v_tryout_apply_auth`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_tryout_apply_auth` AS select `tryout_apply`.`id` AS `id`,`tryout_apply`.`tryoutid` AS `tryoutid`,`tryout_apply`.`fansid` AS `fansid`,`tryout_apply`.`apply_time` AS `apply_time`,`tryout_apply`.`check_time` AS `check_time`,`tryout_apply`.`pass_time` AS `pass_time`,`tryout_apply`.`order_main_id` AS `order_main_id`,`tryout_apply`.`order_item_id` AS `order_item_id`,`tryout_apply`.`reported` AS `reported`,`tryout_apply`.`status` AS `status`,`tryout_apply`.`create_time` AS `create_time`,`order_main`.`status` AS `order_status` from (`tryout_apply` join `order_main` on((`tryout_apply`.`order_main_id` = `order_main`.`id`))) where (`order_main`.`status` in (1,2,3,4)) ;

-- ----------------------------
-- View structure for v_tryout_apply_list
-- ----------------------------
DROP VIEW IF EXISTS `v_tryout_apply_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_tryout_apply_list` AS select `goods`.`name` AS `name`,`tryout_apply`.`id` AS `id`,`tryout`.`start_time` AS `start_time`,`tryout`.`end_time` AS `end_time`,`tryout`.`category` AS `category`,`member`.`username` AS `username`,`member`.`nickname` AS `nickname`,`tryout_apply`.`apply_time` AS `apply_time`,`member`.`level` AS `level`,`tryout`.`tryout_price` AS `tryout_price`,`tryout_apply`.`status` AS `status`,`order_item`.`main_order_id` AS `main_order_id`,`order_main`.`recv_name` AS `recv_name`,`order_main`.`recv_phone` AS `recv_phone`,`order_main`.`address` AS `address`,`order_main`.`province_name` AS `province_name`,`order_main`.`city_name` AS `city_name`,`order_main`.`zone_name` AS `zone_name`,`order_main`.`status` AS `ostatus`,`order_main`.`consumption_category` AS `consumption_category`,`order_main`.`order_number` AS `order_number`,`goods`.`status` AS `gstatus`,`order_main`.`create_time` AS `create_time` from (((((`tryout_apply` join `tryout` on((`tryout_apply`.`tryoutid` = `tryout`.`id`))) join `member` on((`tryout_apply`.`fansid` = `member`.`id`))) join `goods` on((`tryout`.`goodsid` = `goods`.`id`))) join `order_item` on((`tryout_apply`.`order_item_id` = `order_item`.`id`))) join `order_main` on((`order_item`.`main_order_id` = `order_main`.`id`))) where ((`order_main`.`consumption_category` in (3,5)) and (`order_main`.`status` in (1,2,3,4,5,6,7,8,9,10,11))) ;

-- ----------------------------
-- View structure for v_tryout_apply_order_info
-- ----------------------------
DROP VIEW IF EXISTS `v_tryout_apply_order_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_tryout_apply_order_info` AS select `order_item`.`id` AS `id`,`order_item`.`goodsid` AS `goodsid`,`order_item`.`speci_id` AS `speci_id`,`goods`.`speci_json` AS `speci_json`,`order_item`.`status` AS `status`,`goods`.`amount` AS `amount`,`order_item`.`u_id` AS `u_id` from (`order_item` join `goods` on((`order_item`.`goodsid` = `goods`.`id`))) where (`order_item`.`status` in (1,2,3,4)) ;

-- ----------------------------
-- View structure for v_tryout_apply_order_item
-- ----------------------------
DROP VIEW IF EXISTS `v_tryout_apply_order_item`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_tryout_apply_order_item` AS select `tryout_apply`.`tryoutid` AS `tryoutid`,`tryout_apply`.`fansid` AS `fansid`,`tryout_apply`.`id` AS `id` from (`tryout_apply` join `order_item` on((`tryout_apply`.`order_item_id` = `order_item`.`id`))) where (`order_item`.`status` = 4) ;

-- ----------------------------
-- View structure for v_tryout_apply_tryout_list
-- ----------------------------
DROP VIEW IF EXISTS `v_tryout_apply_tryout_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_tryout_apply_tryout_list` AS select `tryout_apply`.`id` AS `id`,`tryout_apply`.`tryoutid` AS `tryoutid`,`tryout_apply`.`fansid` AS `fansid`,`tryout_apply`.`apply_time` AS `apply_time`,`tryout_apply`.`check_time` AS `check_time`,`tryout_apply`.`pass_time` AS `pass_time`,`tryout_apply`.`order_main_id` AS `order_main_id`,`tryout_apply`.`order_item_id` AS `order_item_id`,`tryout_apply`.`reported` AS `reported`,`tryout_apply`.`status` AS `status`,`tryout`.`category` AS `category`,`tryout`.`amount` AS `amount` from (`tryout_apply` join `tryout` on((`tryout_apply`.`tryoutid` = `tryout`.`id`))) ;

-- ----------------------------
-- View structure for v_tryout_apply_view
-- ----------------------------
DROP VIEW IF EXISTS `v_tryout_apply_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_tryout_apply_view` AS select `tryout_apply`.`id` AS `id`,`tryout_apply`.`tryoutid` AS `tryoutid`,`tryout_apply`.`fansid` AS `fansid`,`tryout_apply`.`status` AS `status`,`tryout`.`goodsid` AS `goodsid`,`goods`.`name` AS `name`,`goods`.`title_pic` AS `title_pic`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price`,`tryout_apply`.`apply_time` AS `apply_time`,`tryout_apply`.`order_item_id` AS `order_item_id`,`tryout`.`apply_count` AS `apply_count`,`tryout`.`start_time` AS `start_time`,`tryout`.`end_time` AS `end_time`,`tryout`.`category` AS `category`,`tryout`.`amount` AS `amount`,`tryout`.`tryout_price` AS `tryout_price`,`tryout`.`sequnce` AS `sequnce`,`tryout`.`fans_type` AS `fans_type`,`tryout`.`talent_level` AS `talent_level`,`member`.`nickname` AS `nickname`,`member`.`picpath` AS `picpath`,`tryout_apply`.`create_time` AS `create_time`,`tryout_apply`.`reported` AS `reported`,`order_item`.`status` AS `order_item_status`,`tryout_apply`.`order_main_id` AS `order_main_id`,`order_main`.`consumption_category` AS `consumption_category`,`order_main`.`order_number` AS `order_number` from (((((`tryout` join `tryout_apply` on((`tryout_apply`.`tryoutid` = `tryout`.`id`))) join `goods` on((`tryout`.`goodsid` = `goods`.`id`))) join `member` on((`tryout_apply`.`fansid` = `member`.`id`))) join `order_item` on((`tryout_apply`.`order_item_id` = `order_item`.`id`))) join `order_main` on((`tryout_apply`.`order_main_id` = `order_main`.`id`))) where (`order_item`.`status` in (1,2,3,4,5,6,7,8,9,10,11)) ;

-- ----------------------------
-- View structure for v_tryout_detail
-- ----------------------------
DROP VIEW IF EXISTS `v_tryout_detail`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_tryout_detail` AS select `tryout`.`id` AS `id`,`tryout`.`goodsid` AS `goodsid`,`tryout`.`tryout_price` AS `tryout_price`,`tryout`.`fans_type` AS `fans_type`,`tryout`.`talent_level` AS `talent_level`,`tryout`.`start_time` AS `start_time`,`tryout`.`end_time` AS `end_time`,`tryout`.`apply_count` AS `apply_count`,`goods`.`banner_json` AS `banner_json`,`goods`.`name` AS `name`,`tryout`.`amount` AS `amount`,`tryout`.`category` AS `category`,`tryout`.`sequnce` AS `sequnce`,`tryout`.`status` AS `status`,`goods`.`price` AS `original_price`,`goods`.`details_json` AS `details_json`,`goods`.`speci_json` AS `speci_json`,`goods`.`sale_price` AS `sale_price`,`goods`.`title_pic` AS `title_pic` from (`tryout` join `goods` on((`tryout`.`goodsid` = `goods`.`id`))) ;

-- ----------------------------
-- View structure for v_tryout_left_amount_view
-- ----------------------------
DROP VIEW IF EXISTS `v_tryout_left_amount_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_tryout_left_amount_view` AS select `tryout`.`amount` AS `amount`,`tryout_apply`.`status` AS `apply_status`,`tryout`.`status` AS `status`,`tryout_apply`.`id` AS `id`,`tryout`.`id` AS `tryoutid` from (`tryout` left join `tryout_apply` on((`tryout`.`id` = `tryout_apply`.`tryoutid`))) where (`tryout`.`status` in (3,4)) ;

-- ----------------------------
-- View structure for v_tryout_praise_member
-- ----------------------------
DROP VIEW IF EXISTS `v_tryout_praise_member`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_tryout_praise_member` AS select `tryout_praise`.`id` AS `id`,`tryout_praise`.`u_id` AS `u_id`,`member`.`nickname` AS `nickname`,`member`.`picpath` AS `picpath`,`member`.`level` AS `level`,`tryout_praise`.`tryout_id` AS `tryout_id`,`tryout_praise`.`status` AS `status`,`tryout_praise`.`update_time` AS `update_time`,`member`.`username` AS `username` from (`tryout_praise` join `member` on((`tryout_praise`.`u_id` = `member`.`id`))) ;

-- ----------------------------
-- View structure for v_tryout_report_detail_view
-- ----------------------------
DROP VIEW IF EXISTS `v_tryout_report_detail_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_tryout_report_detail_view` AS select `tryout_report`.`id` AS `id`,`tryout_report`.`tryoutid` AS `tryoutid`,`tryout_report`.`fansid` AS `fansid`,`member`.`nickname` AS `nickname`,`member`.`picpath` AS `picpath`,`tryout_report`.`goodsid` AS `goodsid`,`goods`.`name` AS `goods_name`,`goods`.`price` AS `price`,`goods`.`title_pic` AS `title_pic`,`tryout_report`.`title` AS `title`,`tryout_report`.`content_json` AS `content_json`,`tryout_report`.`status` AS `status`,`tryout_report`.`sequence` AS `sequence`,`tryout_report`.`view_count` AS `view_count`,`tryout_report`.`like_count` AS `like_count`,`member`.`level` AS `level`,`tryout_report`.`istop` AS `istop`,`tryout_report`.`create_time` AS `create_time`,`tryout_report`.`update_time` AS `update_time`,`goods`.`status` AS `gstatus`,`goods`.`activity_json` AS `activity_json`,`member`.`feeling` AS `feeling` from ((`tryout_report` join `member` on((`tryout_report`.`fansid` = `member`.`id`))) join `goods` on((`tryout_report`.`goodsid` = `goods`.`id`))) ;

-- ----------------------------
-- View structure for v_tryout_report_list
-- ----------------------------
DROP VIEW IF EXISTS `v_tryout_report_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_tryout_report_list` AS select `goods`.`name` AS `name`,`tryout_report`.`create_time` AS `create_time`,`tryout_report`.`title` AS `title`,`member`.`nickname` AS `nickname`,`member`.`username` AS `username`,`member`.`level` AS `level`,`tryout_report`.`view_count` AS `view_count`,`tryout_report`.`like_count` AS `like_count`,`tryout_report`.`status` AS `status`,`tryout_report`.`content_json` AS `content_json`,`tryout_report`.`notpass_reason` AS `notpass_reason`,`tryout_report`.`id` AS `id`,`tryout_report`.`goodsid` AS `goodsid`,`tryout_report`.`fansid` AS `fansid`,`tryout_report`.`sequence` AS `sequence`,`tryout_report`.`check_time` AS `check_time`,`tryout_report`.`tryoutid` AS `tryoutid`,`tryout_report`.`default_pic` AS `default_pic`,`member`.`picpath` AS `picpath` from ((`tryout_report` join `goods` on((`tryout_report`.`goodsid` = `goods`.`id`))) join `member` on((`tryout_report`.`fansid` = `member`.`id`))) ;

-- ----------------------------
-- View structure for v_tryout_report_video_goods_view
-- ----------------------------
DROP VIEW IF EXISTS `v_tryout_report_video_goods_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_tryout_report_video_goods_view` AS select `tryout_report_video_goods`.`id` AS `id`,`tryout_report_video_goods`.`goodsid` AS `goodsid`,`tryout_report_video_goods`.`type` AS `type`,`tryout_report_video_goods`.`sequence` AS `sequence`,`tryout_report_video_goods`.`status` AS `status`,`goods`.`name` AS `name`,`goods`.`title_pic` AS `title_pic`,`goods`.`sale_price` AS `sale_price`,`goods`.`price` AS `price`,`goods`.`sale_count` AS `sale_count`,`tryout_report_video_goods`.`report_video_id` AS `report_video_id` from (`tryout_report_video_goods` join `goods` on((`tryout_report_video_goods`.`goodsid` = `goods`.`id`))) ;

-- ----------------------------
-- View structure for v_tryout_report_view
-- ----------------------------
DROP VIEW IF EXISTS `v_tryout_report_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_tryout_report_view` AS select `tryout_report`.`id` AS `id`,`tryout_report`.`fansid` AS `fansid`,`member`.`nickname` AS `nickname`,`member`.`picpath` AS `picpath`,`tryout_report`.`title` AS `title`,`tryout_report`.`default_pic` AS `default_pic`,`tryout_report`.`status` AS `status`,`tryout_report`.`istop` AS `istop`,`tryout_report`.`sequence` AS `sequence`,`tryout_report`.`create_time` AS `create_time`,`tryout_report`.`view_count` AS `view_count`,`tryout_report`.`like_count` AS `like_count`,`tryout_report`.`goods_class_id` AS `goods_class_id`,`member`.`level` AS `level`,`member`.`feeling` AS `feeling`,`tryout_report`.`release_time` AS `release_time` from (`tryout_report` join `member` on((`tryout_report`.`fansid` = `member`.`id`))) ;

-- ----------------------------
-- View structure for v_tryout_view
-- ----------------------------
DROP VIEW IF EXISTS `v_tryout_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_tryout_view` AS select `tryout`.`id` AS `id`,`tryout`.`goodsid` AS `goodsid`,`goods`.`name` AS `name`,`goods`.`title_pic` AS `title_pic`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price`,`goods`.`status` AS `gstatus`,`tryout`.`tryout_price` AS `tryout_price`,`tryout`.`fans_type` AS `fans_type`,`tryout`.`talent_level` AS `talent_level`,`tryout`.`start_time` AS `start_time`,`tryout`.`end_time` AS `end_time`,`tryout`.`apply_count` AS `apply_count`,`tryout`.`category` AS `category`,`tryout`.`amount` AS `amount`,`tryout`.`status` AS `status`,`tryout`.`create_time` AS `create_time`,`tryout`.`update_time` AS `update_time`,(case when (now() > `tryout`.`end_time`) then -(1) else `tryout`.`sequnce` end) AS `sequnce` from (`tryout` join `goods` on((`tryout`.`goodsid` = `goods`.`id`))) ;

-- ----------------------------
-- View structure for v_video_goods
-- ----------------------------
DROP VIEW IF EXISTS `v_video_goods`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_video_goods` AS select `video_goods`.`id` AS `id`,`video_goods`.`video_id` AS `video_id`,`video_goods`.`goods_id` AS `goods_id`,`video_goods`.`status` AS `status`,`video_goods`.`create_time` AS `create_time`,`goods`.`name` AS `name`,`goods`.`title_pic` AS `title_pic`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price`,`goods`.`sale_count` AS `sale_count`,`goods`.`activity_json` AS `activity_json`,`video`.`baby_name` AS `baby_name`,`video`.`status` AS `vstatus`,`video`.`view_count` AS `view_count`,`video`.`summary` AS `summary`,`goods`.`base_sale_count` AS `base_sale_count` from ((`video_goods` join `goods` on(((`video_goods`.`goods_id` = `goods`.`id`) and (`goods`.`status` = 3)))) join `video` on((`video_goods`.`video_id` = `video`.`id`))) where (`video_goods`.`status` < 99) ;

-- ----------------------------
-- View structure for v_video_goods_list
-- ----------------------------
DROP VIEW IF EXISTS `v_video_goods_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_video_goods_list` AS select `video_goods`.`id` AS `id`,`video_goods`.`video_id` AS `video_id`,`video_goods`.`goods_id` AS `goods_id`,`video_goods`.`status` AS `status`,`video_goods`.`create_time` AS `create_time`,`goods`.`name` AS `name`,`goods`.`sale_count` AS `sale_count`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price`,`goods`.`title_pic` AS `title_pic`,`video`.`first_img_path` AS `first_img_path`,`video`.`videopath` AS `videopath`,`video`.`baby_name` AS `baby_name`,`video`.`view_count` AS `view_count`,`video`.`goods_category_id` AS `goods_category_id`,`video`.`summary` AS `summary`,`goods`.`base_sale_count` AS `base_sale_count` from ((`goods` join `video_goods` on((`video_goods`.`goods_id` = `goods`.`id`))) join `video` on((`video`.`id` = `video_goods`.`video_id`))) where ((`video`.`status` = 1) and (`video_goods`.`status` = 1)) ;

-- ----------------------------
-- View structure for v_video_list
-- ----------------------------
DROP VIEW IF EXISTS `v_video_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_video_list` AS select `video`.`id` AS `id`,`video`.`first_img_path` AS `first_img_path`,`video`.`videopath` AS `videopath`,`video`.`baby_name` AS `baby_name`,`video`.`view_count` AS `view_count`,`video`.`goods_category_id` AS `goods_category_id`,`video`.`summary` AS `summary`,`video`.`status` AS `status`,`video`.`create_time` AS `create_time`,`video`.`update_time` AS `update_time`,`v_goods_category`.`id3` AS `id3`,`v_goods_category`.`name3` AS `name3`,`v_goods_category`.`id2` AS `id2`,`v_goods_category`.`name2` AS `name2`,`v_goods_category`.`id1` AS `id1`,`v_goods_category`.`name1` AS `name1`,`video`.`title` AS `title` from (`video` join `v_goods_category` on((`video`.`goods_category_id` = `v_goods_category`.`id3`))) ;

-- ----------------------------
-- View structure for v_video_similar
-- ----------------------------
DROP VIEW IF EXISTS `v_video_similar`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_video_similar` AS select `video_similar_goods`.`id` AS `id`,`video_similar_goods`.`video_id` AS `video_id`,`video_similar_goods`.`goods_id` AS `goods_id`,`video_similar_goods`.`status` AS `status`,`video_similar_goods`.`create_time` AS `create_time`,`goods`.`name` AS `name`,`goods`.`title_pic` AS `title_pic`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price`,`goods`.`sale_count` AS `sale_count`,`goods`.`activity_json` AS `activity_json`,`goods`.`base_sale_count` AS `base_sale_count` from (`video_similar_goods` join `goods` on(((`video_similar_goods`.`goods_id` = `goods`.`id`) and (`goods`.`status` = 3)))) ;

-- ----------------------------
-- View structure for v_video_similar_goodslist
-- ----------------------------
DROP VIEW IF EXISTS `v_video_similar_goodslist`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_video_similar_goodslist` AS select `video_similar_goods`.`id` AS `id`,`video_similar_goods`.`video_id` AS `video_id`,`video_similar_goods`.`goods_id` AS `goods_id`,`video_similar_goods`.`status` AS `status`,`video_similar_goods`.`create_time` AS `create_time`,`video`.`first_img_path` AS `first_img_path`,`video`.`videopath` AS `videopath`,`video`.`view_count` AS `view_count`,`video`.`baby_name` AS `baby_name`,`video`.`goods_category_id` AS `goods_category_id`,`video`.`summary` AS `summary`,`goods`.`name` AS `name`,`goods`.`title_pic` AS `title_pic`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price`,`goods`.`sale_count` AS `sale_count`,`goods`.`base_sale_count` AS `base_sale_count` from ((`video_similar_goods` join `goods` on(((`video_similar_goods`.`goods_id` = `goods`.`id`) and (`goods`.`status` = 3)))) join `video` on((`video_similar_goods`.`video_id` = `video`.`id`))) ;

-- ----------------------------
-- View structure for v_video_similar_goodsList
-- ----------------------------
DROP VIEW IF EXISTS `v_video_similar_goodsList`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_video_similar_goodsList` AS select `video_similar_goods`.`id` AS `id`,`video_similar_goods`.`video_id` AS `video_id`,`video_similar_goods`.`goods_id` AS `goods_id`,`video_similar_goods`.`status` AS `status`,`video_similar_goods`.`create_time` AS `create_time`,`video`.`first_img_path` AS `first_img_path`,`video`.`videopath` AS `videopath`,`video`.`view_count` AS `view_count`,`video`.`baby_name` AS `baby_name`,`video`.`goods_category_id` AS `goods_category_id`,`video`.`summary` AS `summary`,`goods`.`name` AS `name`,`goods`.`title_pic` AS `title_pic`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price`,`goods`.`sale_count` AS `sale_count`,`goods`.`base_sale_count` AS `base_sale_count` from ((`video_similar_goods` join `goods` on(((`video_similar_goods`.`goods_id` = `goods`.`id`) and (`goods`.`status` = 3)))) join `video` on((`video_similar_goods`.`video_id` = `video`.`id`))) ;

-- ----------------------------
-- View structure for v_videodetail
-- ----------------------------
DROP VIEW IF EXISTS `v_videodetail`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_videodetail` AS select `goods_category`.`name` AS `goods_category_name`,`video`.`id` AS `id`,`video`.`first_img_path` AS `first_img_path`,`video`.`videopath` AS `videopath`,`video`.`baby_name` AS `baby_name`,`video`.`view_count` AS `view_count`,`video`.`goods_category_id` AS `goods_category_id`,`video`.`summary` AS `summary`,`video`.`status` AS `status`,`video`.`create_time` AS `create_time`,`video`.`update_time` AS `update_time`,`goods_category`.`pid` AS `pid` from (`goods_category` join `video` on((`video`.`goods_category_id` = `goods_category`.`id`))) ;

-- ----------------------------
-- View structure for v_videoDetail
-- ----------------------------
DROP VIEW IF EXISTS `v_videoDetail`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_videoDetail` AS select `goods_category`.`name` AS `goods_category_name`,`video`.`id` AS `id`,`video`.`first_img_path` AS `first_img_path`,`video`.`videopath` AS `videopath`,`video`.`baby_name` AS `baby_name`,`video`.`view_count` AS `view_count`,`video`.`goods_category_id` AS `goods_category_id`,`video`.`summary` AS `summary`,`video`.`status` AS `status`,`video`.`create_time` AS `create_time`,`video`.`update_time` AS `update_time`,`goods_category`.`pid` AS `pid` from (`goods_category` join `video` on((`video`.`goods_category_id` = `goods_category`.`id`))) ;

-- ----------------------------
-- View structure for video_list_net
-- ----------------------------
DROP VIEW IF EXISTS `video_list_net`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `video_list_net` AS select `video`.`id` AS `id`,`video`.`first_img_path` AS `first_img_path`,`video`.`videopath` AS `videopath`,`video`.`baby_name` AS `baby_name`,`video`.`status` AS `status`,`video`.`create_time` AS `create_time`,`video`.`update_time` AS `update_time`,`video`.`summary` AS `summary`,`video`.`title` AS `title` from `video` where (not(`video`.`id` in (select distinct `main_cfg_video`.`video_id` from `main_cfg_video` where (`main_cfg_video`.`status` < 99)))) ;

-- ----------------------------
-- View structure for goods_list_search
-- ----------------------------
DROP VIEW IF EXISTS `goods_list_search`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `goods_list_search` AS select `goods`.`id` AS `id`,`goods`.`name` AS `name`,`goods`.`title_pic` AS `title_pic`,`goods_brand`.`name` AS `brand_name`,`goods`.`start_time` AS `start_time`,`goods`.`end_time` AS `end_time`,`goods`.`amount` AS `amount`,`goods`.`price` AS `price`,`goods`.`sale_price` AS `sale_price`,`goods`.`send_hour` AS `send_hour`,`goods`.`safeguard_json` AS `safeguard_json`,`goods`.`activity_json` AS `activity_json`,`goods`.`status` AS `status`,`goods`.`create_time` AS `create_time`,`goods`.`update_time` AS `update_time`,`goods_brand`.`id` AS `brand_id`,`v_goods_category`.`id3` AS `category3`,`v_goods_category`.`name3` AS `category_name3`,`v_goods_category`.`id2` AS `category2`,`v_goods_category`.`name2` AS `category_name2`,`v_goods_category`.`id1` AS `category1`,`v_goods_category`.`name1` AS `categroy_name1`,`goods`.`category` AS `category`,`goods`.`sale_count` AS `goods_sale_count`,`goods`.`collection_count` AS `collection_count`,`goods`.`report_count` AS `report_count`,`goods`.`trade_send` AS `trade_send`,`goods`.`hot_sell` AS `hot_sell`,`goods`.`base_sale_count` AS `goods_base_sale_count`,`goods`.`less_stock` AS `less_stock`,`goods`.`base_collection_count` AS `base_collection_count`,`goods`.`sequence` AS `sequence`,`v_goods_on_tags_for_group`.`tag_id` AS `tag_id`,`v_goods_on_tags_for_group`.`tag_name` AS `tag_name`,`v_goods_on_tags_for_group`.`tag_group` AS `tag_group`,`v_goods_on_tags_for_group`.`tag_type` AS `tag_type`,`v_goods_on_tags_for_group`.`status` AS `tag_status`,ifnull(concat(`goods`.`name`,'|',ifnull(`goods_brand`.`name`,''),'|',ifnull(`v_goods_on_tags_for_group`.`tag_name`,''),'|',ifnull(`v_goods_category`.`name1`,''),'|',ifnull(`v_goods_category`.`name2`,''),'|',ifnull(`v_goods_category`.`name3`,'')),'') AS `sch_key` from (((`goods` left join `goods_brand` on((`goods`.`brand` = `goods_brand`.`id`))) left join `v_goods_on_tags_for_group` on((`goods`.`id` = `v_goods_on_tags_for_group`.`goods_id`))) left join `v_goods_category` on((`goods`.`category` = `v_goods_category`.`id3`))) where (`goods`.`status` = 3) ;

-- ----------------------------
-- View structure for member_search
-- ----------------------------
DROP VIEW IF EXISTS `member_search`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `member_search` AS select `member`.`id` AS `id`,`member`.`comp_id` AS `comp_id`,`member`.`username` AS `username`,`member`.`password` AS `password`,`member`.`nickname` AS `nickname`,`member`.`realname` AS `realname`,`member`.`cardnum` AS `cardnum`,`member`.`rank` AS `rank`,`member`.`power_json` AS `power_json`,`member`.`email` AS `email`,`member`.`gender` AS `gender`,`member`.`birth_time` AS `birth_time`,`member`.`status` AS `status`,`member`.`picpath` AS `picpath`,`member`.`wx_openid` AS `wx_openid`,`member`.`pay_openid` AS `pay_openid`,`member`.`level` AS `level`,`member`.`points` AS `points`,`member`.`fans_like_count` AS `fans_like_count`,`member`.`favorite_count` AS `favorite_count`,`member`.`like_talent_count` AS `like_talent_count`,`member`.`feeling` AS `feeling`,`member`.`check_count` AS `check_count`,`member`.`create_time` AS `create_time`,`member`.`update_time` AS `update_time`,concat(`member`.`id`,'|',`member`.`username`,'|',`member`.`nickname`,'|',convert(`member`.`realname` using utf8mb4)) AS `searchVal` from `member` ;

DROP VIEW IF EXISTS `v_points_mall_goods_list`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_points_mall_goods_list`AS select `points_mall_goods`.`id` AS `id`,`points_mall_goods`.`ticket_id` AS `ticket_id`,`points_mall_goods`.`points` AS `points`,`points_mall_goods`.`start_time` AS `start_time`,`points_mall_goods`.`end_time` AS `end_time`,(case `points_mall_goods`.`status` when 3 then ifnull(`v_goods_list`.`status`,`points_mall_goods`.`status`) else `points_mall_goods`.`status` end) AS `status`,`ticket`.`type` AS `type`,(case `points_mall_goods`.`category` when 1 then `ticket`.`name` else `v_goods_list`.`name` end) AS `name`,`ticket`.`full_price` AS `full_price`,`ticket`.`price` AS `price`,`ticket`.`goods_class_json` AS `goods_class_json`,`ticket`.`effect_hour` AS `effect_hour`,`ticket`.`picurl` AS `picurl`,`ticket`.`remark` AS `remark`,`ticket`.`id` AS `ticketid`,`points_mall_goods`.`speci` AS `speci`,`points_mall_goods`.`category` AS `category`,`points_mall_goods`.`amount` AS `amount`,ifnull(`ticket`.`is_show`,0) AS `is_show` from ((`points_mall_goods` left join `ticket` on((`points_mall_goods`.`ticket_id` = `ticket`.`id`))) left join `v_goods_list` on((`points_mall_goods`.`ticket_id` = `v_goods_list`.`id`))) ;