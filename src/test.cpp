#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <iostream>
#include <string>

using namespace cv;
using namespace std;

int main( int argc, char** argv )
{   
    std::string filename = "../data/boundary.png";
    cv::Mat image;
    image = cv::imread(filename, CV_LOAD_IMAGE_COLOR);   


    cv::namedWindow( "Display window", WINDOW_AUTOSIZE );
    cv::imshow( "Display window", image );                  
    cv::waitKey(0);                                          
    return 0;
}
