
-- adjust path to User Directory, file will be hidden
set logfilepath to ("/Users/???/.brightness--.txt" as Unicode text)

-- does the log file already exist?
try
set logfilealias to logfilepath as alias
set logfileexists to true
on error
set logfileexists to false
end try

try
set AppleScript's text item delimiters to "brightness "
do shell script "/bin/brightness -l"
-- get first number after word "brightness" so its safe if multiple displays
set brightness to (words 1 thru 1 of (text item 2 of result)) as real
end try


if brightness as number is greater than 0 then

try
do shell script "/bin/brightness 0"
writeTo(logfilepath, brightness, text, false)
end try

else
try
set brightness to readFile(logfilepath)
do shell script "/bin/brightness " & text of brightness
writeTo(logfilepath, "0", text, false)
end try
end if


on writeTo(targetFile, theData, dataType, apendData)
-- targetFile is the path to the file you want to write
-- theData is the data you want in the file.
-- dataType is the data type of theData and it can be text, list, record etc.
-- apendData is true to append theData to the end of the current contents of the file or false to overwrite it

try
set targetFile to targetFile as string
set openFile to open for access targetFile with write permission
if apendData is false then set eof of openFile to 0
write theData to openFile starting at eof as dataType
close access openFile
return true

on error
try
close access file targetFile
end try
return false
end try
end writeTo

on readFile(unixPath)
set foo to (open for access (POSIX file unixPath))
set txt to (read foo for (get eof foo))
close access foo
return txt
end readFile
