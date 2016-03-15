RELEASE_BRANCH=release/${RELEASE_VERSION}.x
BASE_BRANCH=develop

######pre release

git checkout -b $RELEASE_BRANCH

mvn versions:set -DnewVersion=$RELEASE_VERSION -DgenerateBackupPoms=false

mvn clean deploy

##### tagging

git add pom.xml
git commit -m "version bump"
git tag RELEASE-$RELEASE_VERSION
git push --tags

##### prepare support branch

mvn versions:set -DnewVersion=RELEASE-${RELEASE_VERSION}-SNAPSHOT -DgenerateBackupPoms=false

git add pom.xml
git commit -m "prepare support branch"
git push origin $RELEASE_BRANCH
git checkout $BASE_BRANCH

git merge -s ours $RELEASE_BRANCH && \

git push origin $BASE_BRANCH

