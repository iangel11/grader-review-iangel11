CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

if [[ -f student-submission/ListExamples.java ]]
then 
    echo "ListExamples.java file found! Good, very good."
else
    echo "ListExamples.java file not found..."
    echo "Grade: 0! Do better."
    exit
fi


cp TestListExamples.java student-submission/ListExamples.java grading-area
cp -r lib grading-area

cd grading-area
javac -cp $CPATH *.java

echo "The exit code for the compile step is $?."

if [ $? -eq 0 ]
then
    echo "Compilation successful! Now, running tests..."
    java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > results.txt
    grep -q 'FAILURES!!!' results.txt 
    if [ $? -eq 0 ]
    then
        echo "All tests passed successfully! Niiice job!"
        echo "Grade: Pass"
    else
        echo "Tests failed. See results.txt. Then, come back and do better."
        echo "Grade: 0"
    fi
else
    echo "Compilation failed, check your Java files. Then, come back again. I believe in you."
    echo "Grade: 0"
fi
