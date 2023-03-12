mkdir -p download
while read -r url; do
  echo "下载文件：$url"
  final_url=$(curl -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36 Edg/110.0.1587.69" -L -s -o /dev/null -w '%{url_effective}' $url)
  wget -U "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36 Edg/110.0.1587.69" "$final_url" -P ./download/
done < devUrl.txt

find ./download -iname "*.zip" -print0 | while read -d $'\0' file
do
  unzip -q "$file" -d "${file%.*}" && rm -f "$file"
done

ls ./download/