# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

roles = Role.create([
                      { name: '管理员' },
                      { name: '区域讲师'},
                      { name: '地方讲师'},
                      { name: '特定学员'}
                    ])

areas = Area.create([
                      { name: '华东区' },
                      { name: '华北区'},
                      { name: '华南区'},
                      { name: '华中区'},
                      { name: '东北区' },
                      { name: '西北区'},
                      { name: '东南区'},
                      { name: '西南区'}
                    ])


grades = Grade.create([
                      { name: '营销助理' },
                      { name: '营销主任'},
                      { name: '高级营销主任'},
                      { name: '营销经理'},
                      { name: '高级营销经理' },
                      { name: '营销总监'},
                      { name: '高级营销总监'},
                      { name: '营销经理'}
                    ])


article_categories = ArticleCategory.create([
  { name: '推送文章' },
  { name: '课程介绍' },
  { name: '培训体系介绍' },
  { name: '课程视频' }
])

cells = Cell.create([
  { title: '院长寄语', editable: true, active: true, position: 1 },
  { title: '项目说明', editable: true, active: true, position: 2 },
  { title: '培训日程', editable: false, url: '/weixin/projects/project_id/campaigns', active: true, position: 3 },
  { title: '嘉宾介绍', editable: true, active: true, position: 4 },
  { title: '培训注意事项', editable: true, active: true, position: 5 },
  { title: '精彩花絮', editable: false, url: '/weixin/projects/project_id/features', active: true, position: 6 },
  { title: '合作单位介绍', editable: true, active: true, position: 7 },
  { title: '培训地点', editable: true, active: true, position: 8 },
  { title: '交通安排', editable: true, active: true, position: 9 }
])

pages = Page.create([
  { title: '院长寄语', slug: 'president' },
  { title: '北大简介', slug: 'peking_university' },
  { title: '北大国际', slug: 'peking_international' },
  { title: '行动学习', slug: 'study' },
  { title: '讲师简介', slug: 'teacher' },
  { title: '注意事项', slug: 'notice' },
  { title: '项目介绍', slug: 'introduce' },
  { title: '联系我们', slug: 'contact' },
  { title: '日程安排', slug: 'calendar' },
  { title: '领导自我', slug: 'calendar_project_01' },
  { title: '领导团队', slug: 'calendar_project_02' },
  { title: '实地体验', slug: 'calendar_project_03' },
  { title: '领导业务', slug: 'calendar_project_04' }
])
