# README


##モデル設計

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


## herokuデプロイ手順
1. herokuへログイン

```shell
$ heroku login
```

2. アセットプリコンパイルする

```shell
$ rails assets:precompile RAILS_ENV=production
```

3. コミットする

```shell
$ git add -A
$ git commit -m "init"
```

4. herokuに新しいアプリケーションを作成

```shell
$ heroku create
```

5. heroku stackを変更する

```shell
$ heroku stack:set heroku-18
```

6. heroku buildpackを追加する

```shell
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```

7. herokuにデプロイをする

```shell
$ git push heroku master
```
8. データベースを移行する

```shell
$ heroku run rails db:migrate
```
