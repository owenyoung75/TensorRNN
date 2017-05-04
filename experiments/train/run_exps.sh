#!/bin/bash
timestamp() {
  date +"%T"
}
datestamp() {
  date +"%D"
}

t=$(timestamp)
t="$(echo ${t} | tr ':' '-')"

d=$(datestamp)
d=$(echo ${d} | tr '/' '-')

start_time="$d-$t"

use_error=True #--use_error_prop

#data_path=../../../data/lorenz_series.pkl
#data_path=/cs/ml/datasets/stephan/tensorcompress/lorenz_series.pkl
#chaotic_ts_mat.pkl  chaotic_ts.pkl  lorenz_series_mat.pkl  lorenz_series.pkl  traffic_9sensors.pkl  ushcn_CA.pkl

for exp in lorenz logistic traffic climate 
do	

data_path=/home/roseyu/data/tensorRNN/${exp}.pkl
base_dir=/tmp/tensorRNN/log/$exp/$start_time

echo $base_dir
num_steps=12

hidden_size=128
burn_in_steps=5 # just for naming purposes
learning_rate=0.003
#save_path=$base_dir/basic_rnn/
#python seq_train.py --data_path=$data_path --save_path=$save_path --hidden_size=$hidden_size --num_steps=$num_steps --use_error_prop=$use_error

save_path=$base_dir/basic_lstm/
python seq_train_lstm.py --data_path=$data_path --save_path=$save_path --hidden_size=$hidden_size --num_steps=$num_steps --learning_rate=$learning_rate --use_error_prop=$use_error

#save_path=$base_dir/matrix_rnn/
#python seq_train_matrix.py --data_path=$data_path --save_path=$save_path --hidden_size=$hidden_size --num_steps=$num_steps --use_error_prop=$use_error

#save_path=$base_dir/tensor_rnn/
#python seq_train_tensor.py --data_path=$data_path --save_path=$save_path --hidden_size=$hidden_size --num_steps=$num_steps --use_error_prop=$use_error

save_path=$base_dir/tensor_rnn_einsum/
python seq_train_tensor_einsum.py --data_path=$data_path --save_path=$save_path --hidden_size=$hidden_size --num_steps=$num_steps --learning_rate=$learning_rate --use_error_prop=$use_error

done
