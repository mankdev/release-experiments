RELEASE_BRANCH=release/${RELEASE_VERSION}.x
BASE_BRANCH=develop

######pre release

git checkout -b $RELEASE_BRANCH

mvn release:update-versions -DdevelopmentVersion=$RELEASE_VERSION --batch-mode

mvn clean deploy

##### tagging

git add pom.xml
git commit -m "version bump"
git tag RELEASE-$RELEASE_VERSION
git push --tags

##### prepare support branch

mvn release:update-versions -DdevelopmentVersion=RELEASE-${RELEASE_VERSION}-SNAPSHOT --batch-mode

git commit -m "prepare support branch"
git push origin $RELEASE_BRANCH
git checkout $BASE_BRANCH

git merge -s ours refs/heads/$RELEASE_BRANCH

