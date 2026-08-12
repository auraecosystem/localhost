./config.sh --url https://github.com/Web4application/Nextn --token BH6MBWAXILBGB5FEIIKRZJDKODAE6
curl https://api.openai.com/v1/responses \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -d '{
  "prompt": {
    "id": "pmpt_69b1db2fed9c8195b0c28a9ee51120a508ff0e34f7f4eba6",
    "version": "1"
  }
}'
