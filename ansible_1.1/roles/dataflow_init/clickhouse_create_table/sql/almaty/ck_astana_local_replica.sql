CREATE DATABASE IF NOT EXISTS k19_ods;

CREATE TABLE k19_ods.ntc_collect_account_log_local ( region String,  log_id String,  cfg_id Int64,  found_time Int64,  recv_time Int64,  trans_proto String,  addr_type Int64,  d_ip String,  s_ip String,  d_port Int64,  s_port Int64,  device_id Int64,  direction Int64,  stream_dir Int64,  cap_ip String,  addr_list String,  server_locate String,  client_locate String,  s_asn String,  d_asn String,  s_subscribe_id String,  d_subscribe_id String,  user_region String,  scene_file String,  msisdn String,  imsi String,  imei String,  radius_account String,  app_lable String,  protocol String,  count Int64, second Int64, flow_sequence Int64, nickname String,  username String,  account_id String,  account String,  password String,  password_hash String,  s_country String,  s_city String,  s_geo String, s_long Float64, s_lat Float64, d_country String,  d_city String,  d_geo String, d_long Float64, d_lat Float64) ENGINE = ReplicatedMergeTree('/clickhouse/tables/almaty/{shard}/ntc_collect_account_log_local', '{replica}') PARTITION BY toRelativeHourNum(toDateTime(found_time)) ORDER BY found_time SETTINGS index_granularity = 8192;

CREATE TABLE k19_ods.ntc_collect_http_log_local ( region String,  log_id String,  cfg_id Int64,  found_time Int64,  recv_time Int64,  trans_proto String,  addr_type Int64,  d_ip String,  s_ip String,  d_port Int64,  s_port Int64,  device_id Int64,  direction Int64,  stream_dir Int64,  cap_ip String,  addr_list String,  server_locate String,  client_locate String,  s_asn String,  d_asn String,  s_subscribe_id String,  d_subscribe_id String,  user_region String,  scene_file String,  msisdn String,  imsi String,  imei String,  radius_account String,  app_lable String,  protocol String,  count Int64, second Int64, flow_sequence Int64, url String,  req_body_file String,  req_body_key String,  res_body_file String,  res_body_key String,  website String,  proxy_flag Int64,  req_method String,  req_uri String,  res_status_code String,  cookie String,  referer String,  user_agent String,  content_len String,  content_type String,  set_cookie String,  s_country String,  s_city String,  s_geo String, s_long Float64, s_lat Float64,  d_country String,  d_city String,  d_geo String, d_long Float64, d_lat Float64)  ENGINE = ReplicatedMergeTree('/clickhouse/tables/almaty/{shard}/ntc_collect_http_log_local', '{replica}') PARTITION BY toRelativeHourNum(toDateTime(found_time)) ORDER BY found_time SETTINGS index_granularity = 8192;

CREATE TABLE k19_ods.ntc_collect_lbs_log_local ( region String,  log_id String,  cfg_id Int64,  found_time Int64,  recv_time Int64,  trans_proto String,  addr_type Int64,  d_ip String,  s_ip String,  d_port Int64,  s_port Int64,  device_id Int64,  direction Int64,  stream_dir Int64,  cap_ip String,  addr_list String,  server_locate String,  client_locate String,  s_asn String,  d_asn String,  s_subscribe_id String,  d_subscribe_id String,  user_region String,  scene_file String,  msisdn String,  imsi String,  imei String,  radius_account String,  app_lable String,  protocol String,  count Int64, second Int64, flow_sequence Int64, longitude String,  latitude String,  coordinate_type String,  geo_location String, geo_long Float64, geo_lat Float64) ENGINE = ReplicatedMergeTree('/clickhouse/tables/almaty/{shard}/ntc_collect_lbs_log_local', '{replica}') PARTITION BY toRelativeHourNum(toDateTime(found_time)) ORDER BY found_time SETTINGS index_granularity = 8192;

CREATE TABLE k19_ods.ntc_collect_mail_log_local ( region String,  log_id String,  cfg_id Int64,  found_time Int64,  recv_time Int64,  trans_proto String,  addr_type Int64,  d_ip String,  s_ip String,  d_port Int64,  s_port Int64,  device_id Int64,  direction Int64,  stream_dir Int64,  cap_ip String,  addr_list String,  server_locate String,  client_locate String,  s_asn String,  d_asn String,  s_subscribe_id String,  d_subscribe_id String,  user_region String,  scene_file String,  msisdn String,  imsi String,  imei String,  radius_account String,  app_lable String,  protocol String,  count Int64, second Int64, flow_sequence Int64, mail_from String,  mail_to String,  subject String,  eml_key String,  eml_file String,  mail_cc String,  s_country String,  s_city String,  s_geo String, s_long Float64, s_lat Float64, d_country String,  d_city String,  d_geo String, d_long Float64, d_lat Float64) ENGINE = ReplicatedMergeTree('/clickhouse/tables/almaty/{shard}/ntc_collect_mail_log_local', '{replica}') PARTITION BY toRelativeHourNum(toDateTime(found_time)) ORDER BY found_time SETTINGS index_granularity = 8192;

CREATE TABLE k19_ods.ntc_collect_radius_log_local ( region String,  log_id String,  cfg_id Int64,  found_time Int64,  recv_time Int64,  trans_proto String,  addr_type Int64,  d_ip String,  s_ip String,  d_port Int64,  s_port Int64,  device_id Int64,  direction Int64,  stream_dir Int64,  cap_ip String,  addr_list String,  server_locate String,  client_locate String,  s_asn String,  d_asn String,  s_subscribe_id String,  d_subscribe_id String,  user_region String,  scene_file String,  msisdn String,  imsi String,  imei String,  radius_account String,  app_lable String,  protocol String,  count Int64, second Int64, flow_sequence Int64, code Int64,  nas_ip String,  framed_ip String,  account String,  s_country String,  s_city String,  s_geo String, s_long Float64, s_lat Float64, d_country String,  d_city String,  d_geo String, d_long Float64, d_lat Float64) ENGINE = ReplicatedMergeTree('/clickhouse/tables/almaty/{shard}/ntc_collect_radius_log_local', '{replica}') PARTITION BY toRelativeHourNum(toDateTime(found_time)) ORDER BY found_time SETTINGS index_granularity = 8192;

CREATE TABLE k19_ods.ntc_collect_voip_data_log_local ( region String,  log_id String,  cfg_id Int64,  found_time Int64,  recv_time Int64,  trans_proto String,  addr_type Int64,  d_ip String,  s_ip String,  d_port Int64,  s_port Int64,  device_id Int64,  direction Int64,  stream_dir Int64,  cap_ip String,  addr_list String,  server_locate String,  client_locate String,  s_asn String,  d_asn String,  s_subscribe_id String,  d_subscribe_id String,  user_region String,  scene_file String,  msisdn String,  imsi String,  imei String,  radius_account String,  app_lable String,  protocol String, count Int64, second Int64, flow_sequence Int64, rtp_d_ip String,  rtp_s_ip String,  rtp_d_port Int64,  rtp_s_port Int64,  from_to_store_url String,  to_from_store_url String,  duration String,  call_id String,  request_uri String,  calling_account String,  called_account String,  contacts String,  via String,  route String,  record_route String,  user_agent String,  server String,  s_country String,  s_city String,  s_geo String, s_long Float64, s_lat Float64,  d_country String,  d_city String,  d_geo String,  d_long Float64, d_lat Float64, uuid_correlation String) ENGINE = ReplicatedMergeTree('/clickhouse/tables/almaty/{shard}/ntc_collect_voip_data_log_local', '{replica}') PARTITION BY toRelativeHourNum(toDateTime(found_time)) ORDER BY found_time SETTINGS index_granularity = 8192;

CREATE TABLE k19_ods.ntc_collect_voip_log_local ( region String,  log_id String,  cfg_id Int64,  found_time Int64,  recv_time Int64,  trans_proto String,  addr_type Int64,  d_ip String,  s_ip String,  d_port Int64,  s_port Int64,  device_id Int64,  direction Int64,  stream_dir Int64,  cap_ip String,  addr_list String,  server_locate String,  client_locate String,  s_asn String,  d_asn String,  s_subscribe_id String,  d_subscribe_id String,  user_region String,  scene_file String,  msisdn String,  imsi String,  imei String,  radius_account String,  app_lable String,  protocol String,  count Int64, second Int64, flow_sequence Int64, rtp_d_ip String,  rtp_s_ip String,  rtp_d_port Int64,  rtp_s_port Int64,  from_to_store_url String,  to_from_store_url String,  duration String,  call_id String,  request_uri String,  calling_account String,  called_account String,  contacts String,  via String,  route String,  record_route String,  user_agent String,  server String,  s_country String,  s_city String,  s_geo String, s_long Float64, s_lat Float64, d_country String,  d_city String,  d_geo String, d_long Float64, d_lat Float64, uuid_correlation String) ENGINE = ReplicatedMergeTree('/clickhouse/tables/almaty/{shard}/ntc_collect_voip_log_local', '{replica}') PARTITION BY toRelativeHourNum(toDateTime(found_time)) ORDER BY found_time SETTINGS index_granularity = 8192;

CREATE TABLE k19_ods.ntc_conn_record_log_local ( region String,  log_id String,  cfg_id Int64,  found_time Int64,  recv_time Int64,  trans_proto String,  addr_type Int64,  d_ip String,  s_ip String,  d_port Int64,  s_port Int64,  device_id Int64,  direction Int64,  stream_dir Int64,  cap_ip String,  addr_list String,  server_locate String,  client_locate String,  s_asn String,  d_asn String,  s_subscribe_id String,  d_subscribe_id String,  user_region String,  scene_file String,  msisdn String,  imsi String,  imei String,  radius_account String,  app_lable String,  protocol String,  count Int64, second Int64, flow_sequence Int64, c2s_pkt_num String,  s2c_pkt_num String,  c2s_byte_num String,  s2c_byte_num String,  s_country String,  s_city String,  s_geo String, s_long Float64, s_lat Float64,   d_country String,  d_city String,  d_geo String, d_long Float64, d_lat Float64) ENGINE = ReplicatedMergeTree('/clickhouse/tables/almaty/{shard}/ntc_conn_record_log_local', '{replica}') PARTITION BY toRelativeHourNum(toDateTime(found_time)) ORDER BY found_time SETTINGS index_granularity = 8192;

CREATE TABLE k19_ods.ntc_collect_im_log_local ( region String,  log_id String,  cfg_id Int64,  found_time Int64,  recv_time Int64,  trans_proto String,  addr_type Int64,  d_ip String,  s_ip String,  d_port Int64,  s_port Int64,  device_id Int64,  direction Int64,  stream_dir Int64,  cap_ip String,  addr_list String,  server_locate String,  client_locate String,  s_asn String,  d_asn String,  s_subscribe_id String,  d_subscribe_id String,  user_region String,  scene_file String,  msisdn String,  imsi String,  imei String,  radius_account String,  app_lable String,  protocol String,  count Int64, second Int64, flow_sequence Int64, im_from String, im_to String,im_type String,im_msg String, s_country String,  s_city String,  s_geo String,  s_long Float64, s_lat Float64, d_country String,  d_city String,  d_geo String, d_long Float64, d_lat Float64) ENGINE = ReplicatedMergeTree('/clickhouse/tables/almaty/{shard}/ntc_collect_im_log_local', '{replica}') PARTITION BY toRelativeHourNum(toDateTime(found_time)) ORDER BY found_time SETTINGS index_granularity = 8192;

CREATE TABLE k19_ods.ntc_collect_nat_log_local ( region String,  log_id String,  cfg_id Int64,  found_time Int64,  recv_time Int64,  trans_proto String,  addr_type Int64,  d_ip String,  s_ip String,  d_port Int64,  s_port Int64,  device_id Int64,  direction Int64,  stream_dir Int64,  cap_ip String,  addr_list String,  server_locate String,  client_locate String,  s_asn String,  d_asn String,  s_subscribe_id String,  d_subscribe_id String,  user_region String,  scene_file String,  msisdn String,  imsi String,  imei String,  radius_account String,  app_lable String,  protocol String, count Int64, second Int64, flow_sequence Int64, proto Int64, operator Int64, ip_version Int64, ipv4_tos Int64, src_ip String, src_natip String, dest_ip String, dest_natip String, src_port Int64,src_natport Int64,dest_port Int64,dest_natport Int64,start_time Int64,end_time Int64,in_totalpkg Int64,in_totalbyte Int64,out_totalpkg Int64,out_totalbyte Int64,src_vpn String, dst_vpn String) ENGINE = ReplicatedMergeTree('/clickhouse/tables/almaty/{shard}/ntc_collect_nat_log_local', '{replica}') PARTITION BY toRelativeHourNum(toDateTime(found_time)) ORDER BY found_time SETTINGS index_granularity = 8192;

CREATE TABLE k19_ods.dm_conv_log_local ( region String,  log_id String,  source_unit_name String,  found_time Int64,  end_time Int64,  client_ip String,  server_ip String,  service_id String,  lineid String,  pipe_id String,  vcid String,  instance_type String,  instance_key_1 String,  instance_key_2 String,  net_unit_id String,  client_device_name String,  client_device_class String,  client_device_vendor String,  client_device_model String,  client_device_os_name String,  client_device_os_fullVersion String,  client_device_os_majorVersion String,  tethering_indication String,  next_hop_as String,  destination_as String,  monitored_service_group_id String,  rating_group String,  session_rat String,  live_connections String,  new_connections String,  packets_in String,  packets_out String,  octets_in String,  octets_out String,  network_activity_time_sec Int64,  retransmitted_tcp_data_segments_in String,  total_tcp_data_segments_in String,  retransmitted_tcp_data_segments_out String,  total_tcp_data_segments_out String,  rttEstimate_external_avg_m_sec Int64,  rttEstimate_external_sum_m_sec Int64,  rttEstimate_externa_events_m_sec Int64,  rttEstimate_internal_avg_m_sec Int64,  rttEstimate_internal_sum_m_sec Int64,  rttEstimate_interna_events_m_sec Int64,  max_bandwidth_kbps Int64,  min_bandwidth_kbps Int64,  voip_session_duration String,  qos_dropped_packets_in String,  qos_dropped_packets_out String,  qos_dropped_octets_in String,  qos_dropped_octets_out String,  s_country String,  s_city String,  s_geo String, s_long Float64, s_lat Float64,  d_country String,  d_city String,  d_geo String, d_long Float64, d_lat Float64) ENGINE = ReplicatedMergeTree('/clickhouse/tables/almaty/{shard}/dm_conv_log_local', '{replica}') PARTITION BY toRelativeHourNum(toDateTime(found_time)) ORDER BY found_time SETTINGS index_granularity = 8192;

/**

CREATE TABLE k19_ods.dm_hdr_log_local ( region String,  log_id String,  source_unit_name String,  found_time Int64,  subscriber_id String,  session_key String,  client_ip String,  client_port Int64,  server_ip String,  server_port Int64,  service_id String,  http_method String,  request_header_host String,  uri String,  download_content_length Int64,  upload_content_length Int64,  request_actual_byte_count Int64,  response_actual_byte_count Int64,  response_code Int64,  server_initial_response_time Int64,  duration Int64,  request_header_dnt_x_do_not_track String,  request_header_user_agent String,  request_header_referer String,  response_header_content_type String,  l5protocol String,  client_device_name String,  client_device_class String,  client_device_vendor String,  client_device_model String,  client_device_os_name String,  client_device_os_FullVersion String,  client_device_os_major_version String,  line_id String,  pipe_id String,  vcid String,  cdn String,  imsi String,  imeisv String,  action String,  s_country String,  s_city String,  s_geo String,  s_long Float64, s_lat Float64, d_country String,  d_city String,  d_geo String, d_long Float64, d_lat Float64) ENGINE = ReplicatedMergeTree('/clickhouse/tables/almaty/{shard}/dm_hdr_log_local', '{replica}') PARTITION BY toRelativeHourNum(toDateTime(found_time)) ORDER BY found_time SETTINGS index_granularity = 8192;

**/


/**网络行为分析**/
CREATE DATABASE IF NOT EXISTS zt;

DROP TABLE IF EXISTS zt.cdr_local;
CREATE TABLE zt.cdr_local (   record_type String,   record_id String,   found_time Int64,   calling_party_number String,   called_party_number String,   redirecting_number String,   call_id_number String,   supplementary_services String,   cause String,   calling_party_category String,   call_duration String,   call_status String,   connected_number String,   imsi_calling String,   imei_calling String,   imsi_called String,   imei_called String,   msisdn_calling String,   msisdn_called String,   msc_number String,   vlr_number String,   location_lac String,   location_cell String,   forwarding_reason String,   roaming_number String,   ss_code String,   ussd String,   operator_id String,   date_and_time Int64,   call_direction String,   ll String ) ENGINE = ReplicatedMergeTree('/clickhouse/tables/almaty/{shard}/ntc_collect_nat_log_local', '{replica}') PARTITION BY toRelativeHourNum(toDateTime(found_time)) ORDER BY   found_time SETTINGS index_granularity = 8192;

DROP TABLE IF EXISTS zt.email_local ;
CREATE TABLE zt.email_local (   found_time Int64,   msisdn_calling String,   protocol String,   source_ip String,   source_port Int64,   dst_ip String,   dst_port Int64,   msg_id Int64,   subject String,   from     String,     to String,     reply_to String,     cc String,     bcc String,     received String,     return_path String,     comments String,     in_reply_to String,     content_type String,     filenames String ) ENGINE = ReplicatedMergeTree('/clickhouse/tables/almaty/{shard}/ntc_collect_nat_log_local', '{replica}') PARTITION BY toRelativeHourNum(toDateTime(found_time)) ORDER BY   found_time SETTINGS index_granularity = 8192;


DROP TABLE IF EXISTS zt.http_local ;
CREATE TABLE zt.http_local (   action Int64,   version Int64,   uri String,   domain String,   found_time Int64,   msisdn String,   source_ip String ) ENGINE = ReplicatedMergeTree('/clickhouse/tables/almaty/{shard}/ntc_collect_nat_log_local', '{replica}') PARTITION BY toRelativeHourNum(toDateTime(found_time)) ORDER BY   found_time SETTINGS index_granularity = 8192;

DROP TABLE IF EXISTS zt.loc_local;
CREATE TABLE zt.loc_local (   msisdn String,   lac Int64,   cell Int64,   found_time Int64,   loc_type Int64,   imsi String,   imei String,   ll String,   switchgear_type String ) ENGINE = ReplicatedMergeTree('/clickhouse/tables/almaty/{shard}/ntc_collect_nat_log_local', '{replica}') PARTITION BY toRelativeHourNum(toDateTime(found_time)) ORDER BY   found_time SETTINGS index_granularity = 8192;
