# README

#### Userモデル

|  カラム名  |  データ型  |
| :---: | :---: |
|  id  |  integer  |
|  user_name  |  string  |
|  email  |  string  |
|  password  |  string  |


#### Taskモデル

|  カラム名  |  データ型  |
| :---: | :---: |
|  id  |  integer  |
|  user_id  |  integer  |
|  task_name  |  string  |
|  discription  |  text  |
|  deadline  |  datetime  |
|  status  |  string  |
|  priority  |  string  |

#### Task_labelsモデル

|  カラム名  |  データ型  |
| :---: | :---: |
|  id  |  integer  |
|  task_id  |  integer  |
|  label_id  |  integer  |

#### Labelモデル

|  カラム名  |  データ型  |
| :---: | :---: |
|  id  |  integer  |
|  label_name  |  string  |
