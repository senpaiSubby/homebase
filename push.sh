# __       _     _           
#/ _\_   _| |__ | |__  _   _ 
#\ \| | | | '_ \| '_ \| | | |
#_\ \ |_| | |_) | |_) | |_| |
#\__/\__,_|_.__/|_.__/ \__, |
#                      |___/ 


git add .

echo 'Enter the commit message:'
read commitMessage

git commit -m "$commitMessage"

echo 'Enter the name of the branch:'
read branch

git push origin $branch

read
notify-send "Push Complete"
