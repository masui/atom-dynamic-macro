#
# % make patch: パッチ番号をインクリメントして公開
# % make minor: マイナーリビジョン番号をインクリメントして公開
# % make major: メジャーリビジョン番号をインクリメントして公開
#
test:
	apm test
	
patch:
	apm publish patch

minor:
	apm publish minor

major:
	apm publish major



