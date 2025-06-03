```bash
# separately on amd64/arm64
./0_pull_images.sh images.txt
./1_export_image_versions.py --arch $(dpkg --print-architecture) images.$(dpkg --print-architecture).txt

# one-time joining of amd64/arm64 information
./2_generate_version_table.py image_versions-amd64.csv image_version-arm64.csv
```
