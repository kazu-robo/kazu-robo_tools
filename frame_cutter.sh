#!/bin/bash

# TODO tab補完効くようにしたい
read -p "input the file name : " file # file is mp4 for example

# TODO tmpでおく名前のファイルが該当ディレクトリに事前に存在しないか確認
# if your video is shorter than 1 sec, change fps bigger than (1/video_length)
ffmpeg -i $file -ss 0 -f image2 -vf fps=1 example%05d.png
gnome-open example00001.png

echo -e "\n\n"
echo "------------------------------ usage ------------------------------"
echo -e "width (pixel) : 100 \n height (pixel) : 100 \n x of the left-up corner (pixel) : 50  \n y of the left-up corner (pixel) : 50 \n"
echo -e "-------------- image -------------\n"
echo "------|---------------------------"
echo "----50|---------------------------"
echo "------|---------------------------"
echo "__50__=============---------------"
echo "-----||----100----||--------------"
echo "-----||-----------||--------------"
echo "-----||100--------||--------------"
echo "-----||----output-||--------------"
echo "-----||-----------||--------------"
echo "-----||===========||--------------"
echo "----------------------------------"
echo "----------------------------------"
echo -e "----------------------------------\n\n"

during_check=true

geometry=$(identify -verbose example00001.png | grep "Page geometry: ")
IFS=:
geometry_size=(${geometry})
IFS=x
geometry_arr_x=(${geometry_size[1]})
IFS=+
geometry_arr_y=(${geometry_arr_x[1]})
echo -e "The size of input video file is width:${geometry_arr_x[0]} pixel and height: ${geometry_arr_y[0]} pixel \n"

# TODO tmpでおく名前のファイルが該当ディレクトリに事前に存在しないか確認
while "${during_check}"
do
    read -p "width (pixel) : " width
    read -p "height (pixel) : " height
    read -p "x of the upper left corner (pixel) : " corner_x
    read -p "y of the upper left corner (pixel) : " corner_y
    convert -crop "${width}x${height}+${corner_x}+${corner_y}" example00001.png  tmp_crop.png
    gnome-open tmp_crop.png

    read -p "Trimming ok with this? (y/N): " yn
    case "$yn" in
        [yY]*) during_check=false;;
    esac
done

read -p "fps (frame per second) : " fps
read -p "output file name : " output_file
read -p "start second [sec]:  " start_sec
read -p "time length of cutting out [sec]: " time
mkdir $output_file

# TODO tmpでおく名前のファイル,ディレクトリが該当ディレクトリに事前に存在しないか確認
ffmpeg -i $file -ss $start_sec -t $time -f image2 -vf fps=$fps tmp_output%05d.png
convert -crop "${width}x${height}+${corner_x}+${corner_y}" tmp_output*.png ${output_file}/${output_file}_fps${fps}_%05d.png

rm tmp_crop.png example*.png tmp_output*.png

# killall eog # eogという名前の全プロセスの終了
# pkill eog # eogを名前に含む全プロセスの終了
# TODO ps aux なりなんなりからパイプライン、直前のeogをkillしたい
read -p "pkill eog? (y/N) [!!caution!! if y, all eog windows will be killed]: " yn
    case "$yn" in
        [yY]*) pkill eog
    esac

