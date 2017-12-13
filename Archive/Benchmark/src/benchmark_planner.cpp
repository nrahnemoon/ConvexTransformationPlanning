#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <iostream>
#include <string>
#include <cmath>
#include <queue>





struct Node
{
	int index;
	double g_value;
};



struct compare
{
  bool operator()(const Node* n1, const Node* n2) {
      return n1->g_value > n2-> g_value;}
};



int get_id(std::pair<int,int> coord, int map_x_size)
{
	return ((coord.second)*map_x_size + (coord.first));
}


std::pair<int ,int> get_coordinates(int index, int map_x_size)
{
	int y = index / map_x_size;
	int x = index - map_x_size*y;
	return {x,y};
}



bool get_map(int index, cv::Mat map)
{
	int row = index / map.cols;
	int col = index - map.cols*row;

	if ((int)map.at<uchar>(row,col) == 0)
		return true;
	return false;

}




int main( int argc, char** argv )
{   

    std::string filename = "../data/img.png";
    cv::Mat map;
    map = cv::imread(filename, 0);   

    for(int i = 0; i < map.rows; i++) {
        for(int j = 0; j < map.cols; j++) {
            // std::cout<< (int)map.at<uchar>(i,j) <<" ";
        }
        // std::cout<<std::endl;
    }

    std::pair<int,int> start_position = {80,55}, goal_position = {30,80};

    std::cout<< (int)map.at<uchar>(start_position.second,start_position.first);
    std::cout<<"\n\n\n\n";
    std::cout<< (int)map.at<uchar>(goal_position.second,goal_position.first);
    std::cout<<"\n\n\n\n";

    std::cout<<"ROWS:"<<map.rows << "COL: " << map.cols;






    double max_move_value = 30000000;
    int map_size =  map.rows *  map.cols;
    std::vector<double> move_value(map_size, max_move_value);
    std::vector<int> parent(map_size, -1);


    std::priority_queue<Node*, std::vector<Node*>,compare > open;

    const int goal_index = get_id(goal_position, map.cols);
    const int start_index = get_id(start_position,map.cols );

    std::cout<<"\n\n\n"<<start_index<<"\n\n\n";

   // SPECIFY GOAL move_value TO BE 0, move_value COMPUTED AS DIJKSHTRA FROM GOAL TO START
    move_value[start_index] = 0;

    // std::priority_queue<Node*, std::vector<Node*>,compare > open;s
    std::queue<int> open_list;
    open_list.push(start_index);


    Node* start_node = new Node();
    start_node -> index = start_index;
    start_node -> g_value = 0;

    open.push(start_node);
    // NO CHECK FOR REACHING FROM GOAL TO START CONDITION AS move_value IS COMPUTED FOR ALL GRID COORDINATES
    while(!open.empty()) {

        // STORE THE FRONT OF THE PRIORITY QUEUE
        auto temp = open.top();
        auto temp_node = temp -> index;
        // auto temp_node = open_list.front();

        // REMOVE TOP ELEMENT FROM OPEN LIST
        open_list.pop();
        open.pop();
        
        // CPECIFY CHILD INDICES: EXCEPT EDGE CASES WHEN THE ROBOT IS ON THE EDGES
        std::vector<int> child_indices = {map.cols, -map.cols};

        if(temp_node % map.cols != 0) {
        	child_indices.push_back(-map.cols - 1);
        	child_indices.push_back(map.cols - 1);
            child_indices.push_back(-1);
        }

        if((temp_node+1) % map.cols != 0) {       	
        	child_indices.push_back(-map.cols + 1);
        	child_indices.push_back(map.cols + 1);
            child_indices.push_back(1);
		}

        //UPDATE MOVE VALUES
        for(auto i : child_indices) {
            int child = temp_node + i;

            if(child >= 0 && child < map_size && get_map(child, map)==false && move_value[child] == max_move_value) {
                if(i == map.cols || i == -map.cols || i == -1 || i == 1)
	                move_value[child] = move_value[temp_node] + 1;
	            else
	            	move_value[child] = move_value[temp_node] + 1.414;
                open_list.push(child);
                Node* child_node = new Node();
                child_node -> index = child;
                child_node -> g_value = move_value[child];

                open.push(child_node);

                parent[child] = temp_node;
            }
        }
    }

    cv::Mat path;
    path =  cv::Mat::zeros(map.rows, map.cols, CV_8U);


        for(auto i : move_value)
        	std::cout<<i<<"  ";
        std::cout<<std::endl<<std::endl;
	    // std::cout<<"\n\n\n\n" <<parent[goal_index] << "\n\n\n\n";
	    int id = parent[goal_index];
	    while(id != start_index){
	    // std::cout<<"\n\n\n\n" <<get_coordinates(id, 100).first<<" " <<
	    // get_coordinates(id, 100).second  << "\n\n\n\n";

	    map.at<uchar>(get_coordinates(id, 100).second,get_coordinates(id, 100).first) = 100;
		path.at<uchar>(get_coordinates(id, 100).second,get_coordinates(id, 100).first) = 100;
	
	    id = parent[id];
		}



    cv::namedWindow( "Display window", cv::WINDOW_AUTOSIZE );
    cv::imshow( "Display window", map );   
    cv::imwrite("map.jpg", map);
    cv::imwrite("path.jpg", path);               
    cv::waitKey(0);                                          
    return 0;
}
