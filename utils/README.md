```bash
# on amd64
./export_image_versions.py --arch amd64 images-amd64.txt

# on arm64
./export_image_versions.py --arch arm64 images-arm64.txt

# join
./generate_version_table.py image_versions-amd64.csv image_version-arm64.csv
```
