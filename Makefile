build:
	swift build

release: clean
	swift build -c=release --build-path ./.release

clean:
	rm -rf ./.build ./.release
