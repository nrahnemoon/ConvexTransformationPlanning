#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <iostream>
#include <string>
#include <cmath>

using namespace cv;
using namespace std;




int get_node_id(int x, int y, int x_size, int y_size){
    return x + x_size*y; 
}

std::vector< std::pair<int,int> > get_boundary (const cv::Mat& image)
{
    std::vector< std::pair<int,int> > boundary;
    for(int i = 0; i < image.rows;i++){
        for(int j = 0; j < image.cols; j++){
            if((int)image.at<uchar>(i,j) == 0){
                boundary.push_back({i,j});
            }
        }
    }
    return boundary;    
}

std::vector<double> get_slopes(std::vector< std::pair<int,int> > boundary, std::pair<int, int> center)
{
    std::vector<double> slopes;
    double slope;
    double threshold = 0.0001;
    double max_slope = 10000;
    for(int i = 0; i < boundary.size(); i++){
        if(fabs((float)center.second - (float)boundary[i].second) < threshold){
            if((float)center.first - (float)boundary[i].first > 0){
                slopes.push_back(max_slope);
            }
            else {
                slopes.push_back(- max_slope);   
            }
        }
        else{
            slope =  ( (float)center.first - (float)boundary[i].first )/ ((float)center.second - (float)boundary[i].second);
            slopes.push_back(slope);
        }
    }
    return slopes;
}

int main( int argc, char** argv )
{   
    std::string filename = "../data/boundary.png";
    cv::Mat image;
    image = cv::imread(filename, 0);   

    std::vector< std::pair<int,int> > boundary = get_boundary(image);
    
    std::pair<int, int> center;

    center.first = 50;
    center.second = 50;

    int K = 50;

    std::vector<double> slopes = get_slopes(boundary, {50, 50});

    
    // for(auto i : boundary){
    //     std::cout<<i.first<<" "<<i.second<<std::endl;
    // }

    // std::sort(slopes.begin(),slopes.end());


    Mat C = Mat(boundary.size(),K, CV_64F, double(0));

    for(int i = 0; i < C.rows; i++) {
        for(int j = 0; j < C.cols; j++) {
            C.at<double>(0,0) = 1;
        }
    }


    // for(auto i : slopes){
    //     std::cout<<i<<std::endl;
    // }

    cv::namedWindow( "Display window", WINDOW_AUTOSIZE );
    cv::imshow( "Display window", image );                  
    cv::waitKey(0);                                          
    return 0;
}
