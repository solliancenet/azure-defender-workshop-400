function CreateFiles($count)
{
    #This will generate several random text files.
    $i = 0;

    while($i -le $count)
    {
        #add content
        $filePath = "$oneDrivePath\$i.txt";

        while($j -le $count)
        {
            add-content "$filePath" "$j";

            $j++;
        }

        $j = 0;
        $i++;
    }
}

$oneDrivePath = "C:\Users\wsuser\OneDrive";

CreateFiles 100;