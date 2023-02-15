# Estudos
teste 
git config user.name "FranciscoPimentel"
git config user.email "kikopimentel12@gmail.com"
teste commit 




sudo timeshift --create --comments "new backup" --tags D --snapshot-device /dev/sda1
sudo timeshift --create --comments "Test" --tags D --snapshot-device /dev/sdb1
sudo timeshift --list --snapshot-device /dev/sdb1
sudo timeshift --restore --snapshot
sudo timeshift --create --comments "test_backup" --tags D --snapshot-device /dev/sdb1
timeshift --delete --snapshot '2014-10-12_16-29-08'