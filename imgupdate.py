import os

# List of station folders to process
stations = ["Aliante", "Center", "Dragon_Ridge", "Red_Rock", "Sunset"]

base_path = "./web/assets"
base_url_root = "https://nevmet.netlify.app/assets/"

for station in stations:
    directory = os.path.join(base_path, station)
    base_url = base_url_root + station + "/"

    if not os.path.isdir(directory):
        print(f"Directory not found: {directory}")
        continue

    for filename in os.listdir(directory):
        if filename.endswith(".htm") or filename.endswith(".html"):
            path = os.path.join(directory, filename)
            try:
                with open(path, "r", encoding="utf-8") as f:
                    content = f.read()

                # Replace all image src references like src="StationName/...
                content = content.replace(f'src="{station}/', f'src="{base_url}')

                with open(path, "w", encoding="utf-8") as f:
                    f.write(content)

                print(f"Updated: {path}")
            except Exception as e:
                print(f"Error updating {path}: {e}")

