Rina docker
-----------

## Step 1. start docker
1. `cp env.example .env`, change port if needed
2. replace cert.key / cert.pem with real cert (line requires HTTPS, you can also use CloudFlare)
3. `docker-compose build`
4. `docker-compose up`
5. go to https://localhost:443

## Step 2. get line tokens & line setup
1. Go to https://developers.line.biz/ja/
2. Create messaging api channel
3. In "Basic Settings", copy `channel_id`, `channel_secret`
4. In "Messaging API", issue channel access token
5. In "Messaging API", change webook to
   `https://YOUR_HOST_NAME/webhooks/line`
   verify & enable
6. Disable greeting messages
