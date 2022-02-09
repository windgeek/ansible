#!/usr/bin/env bash
base_rest_url=${1}
echo 'ip port:'${base_rest_url}
sh template/k19_default_template.sh ${base_rest_url}
sh template/k19_http_account_template.sh ${base_rest_url}
sh template/k19_http_content_template.sh ${base_rest_url}
sh template/k19_im_chat_template.sh ${base_rest_url}
sh template/k19_im_profile_template.sh ${base_rest_url}
sh template/k19_im_voip_template.sh ${base_rest_url}
sh template/k19_mail_content_template.sh ${base_rest_url}
sh template/k19_social_chat_template.sh ${base_rest_url}
sh template/k19_social_posts_template.sh ${base_rest_url}
sh template/k19_social_profile_template.sh ${base_rest_url}
sh template/k19_web_mail_template.sh ${base_rest_url}
