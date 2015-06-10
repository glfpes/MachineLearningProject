1）    Original data：

[
{
 "tower_status_dire": 2047, 
 "barracks_status_dire": 63, 
 "match_id": 559913632, 
 
"players": [
  
{
   "denies": 1, 
   "xp_per_min": 199, 
   "player_slot": 0, 
   "kills": 0, 
   "level": 7, 
   "deaths": 2, 
   "hero_damage": 955, 
   "last_hits": 36, 
   "hero_id": 69, 
   "tower_damage": 0, 
   "gold_per_min": 250
  }, 
  
{
   "denies": 0, 
   "xp_per_min": 256, 
   "player_slot": 1, 
   "kills": 2, 
   "level": 8, 
   "deaths": 3, 
   "hero_damage": 1139, 
   "last_hits": 10, 
   "hero_id": 25, 
   "tower_damage": 22, 
   "gold_per_min": 170
  }, 
  
{
   "denies": 1, 
   "xp_per_min": 135, 
   "player_slot": 2, 
   "kills": 1, 
   "level": 6, 
   "deaths": 5, 
   "hero_damage": 3475, 
   "last_hits": 10, 
   "hero_id": 64, 
   "tower_damage": 0, 
   "gold_per_min": 154
  }, 
 
{
   "denies": 3, 
   "xp_per_min": 190, 
   "player_slot": 3, 
   "kills": 0, 
   "level": 7, 
   "deaths": 2, 
   "hero_damage": 674, 
   "last_hits": 18, 
   "hero_id": 49, 
   "tower_damage": 52, 
   "gold_per_min": 161
  }, 
  
{
   "denies": 10, 
   "xp_per_min": 160, 
   "player_slot": 4, 
   "kills": 0, 
   "level": 6, 
   "deaths": 5, 
   "hero_damage": 1616, 
   "last_hits": 21, 
   "hero_id": 48, 
   "tower_damage": 0, 
   "gold_per_min": 176
  }, 

{
   "denies": 6, 
   "xp_per_min": 250, 
   "player_slot": 128, 
   "kills": 2, 
   "level": 8, 
   "deaths": 1, 
   "hero_damage": 5733, 
   "last_hits": 28, 
   "hero_id": 102, 
   "tower_damage": 1587, 
   "gold_per_min": 515
  }, 
  
{   
"denies": 17, 
   "xp_per_min": 473, 
   "player_slot": 129, 
   "kills": 3, 
   "level": 11, 
   "deaths": 0, 
   "hero_damage": 3876, 
   "last_hits": 63, 
   "hero_id": 74, 
   "tower_damage": 4011, 
   "gold_per_min": 650
  }, 
  
{
   "denies": 1, 
   "xp_per_min": 300, 
   "player_slot": 130, 
   "kills": 2, 
   "level": 9, 
   "deaths": 1, 
   "hero_damage": 3801, 
   "last_hits": 29, 
   "hero_id": 27, 
   "tower_damage": 2462, 
   "gold_per_min": 505
  }, 
  
{
   "denies": 0, 
   "xp_per_min": 316, 
   "player_slot": 131, 
   "kills": 8, 
   "level": 9, 
   "deaths": 1, 
   "hero_damage": 9023, 
   "last_hits": 33, 
   "hero_id": 30, 
   "tower_damage": 753, 
   "gold_per_min": 593
  }, 
  
{
   "denies": 29, 
   "xp_per_min": 446, 
   "player_slot": 132, 
   "kills": 1, 
   "level": 11, 
   "deaths": 1, 
   "hero_damage": 2404, 
   "last_hits": 71, 
   "hero_id": 93, 
   "tower_damage": 1179, 
   "gold_per_min": 571
  }

 ], 
 
"barracks_status_radiant": 48, 
 "tower_status_radiant": 256, 
 "duration": 911, 
 "radiant_win": false
},




2）     input data 10x11x比赛局数

共读入100000局比赛，1-90000训练集  90001-100000测试集

数据初始化 每局比赛减所有局比赛的平均值     （作为网络输入）

3）     实验

CNN（卷积神经网络）bp更新4500次     http://blog.csdn.net/zouxy09/article/details/8781543/

随机梯度下降法 （gradient descent）

代价函数 softmax                    http://ufldl.stanford.edu/wiki/index.php/Softmax%E5%9B%9E%E5%BD%92


lossfunction.jpg      训练时代价函数变化曲线
error rate.jpg        训练集判错率
test error rate.jpg   测试集判错率                     （网络每次更新后，测试集中随机抽500局比赛测试）



模型预测正确率：98.33%


