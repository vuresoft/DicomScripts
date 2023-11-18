# Clear tags (removes them completely)
dcmodify -ie -gin -nb -ea "(0010,0010)" -ea "(0008,0080)" -ea "(0008,0081)" -ea "(0008,0090)" *.dcm 

# Modify existing tag
dcmodify -ie -nb -m "(0010,0010)=Mr. John Doe"  *.dcm

# insert new tag
dcmodify -ie -nb -m "(0010,0010)=Mr. John Doe"  *.dcm
