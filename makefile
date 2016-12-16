define showFirstName
	@echo $(1)
	@echo $(2)
	@echo $(MAKE_VERSION)
	@echo $(CURDIR)
	@echo $(MAKEFILE_LIST)
	@echo $(VARIABLE)
	@echo $(CC)
	@echo $(CXX)
	@echo $(CXXFLAGS)
	@echo $(APPFLAGS)
	@echo $(LDLIBS)
	@echo $(wildcard *.c)
endef

.PHONY: showFirstName
name:
	$(call showFirstName,zzyypp,zhangsan)

# ======================================
# .PHONY声明的目标总是执行其指定的命令，如果不声明的话，则仅当目标后面的条件变动后才执行
# 命令前面的@符号的作用是，不显示被执行的命令，默认会打印执行的命令


$(info start working)
.PHONY:test
test: f1.o f2.o main.o
	gcc -o main.bin f1.o f2.o main.o

f1.o: f1.c
	gcc -c f1.c -o f1.o
f2.o: f2.c
	gcc -c f2.c -o f2.o

main.o: main.c
	gcc -c main.c -o main.o



# ==============模板目标========================
#  脚本中的内置符号
#  $@ : 代表目标名称  
#  $< : 代表第一个先决条件的名称 
#  $^ : 所有的先决条件   
#  $+ : 所有有先决条件，和$^类似，只是包含了重复的先决条件
#  $* : 和$@类似，只是不包含targert后缀  
#  $? : 有更新的先决条件列表 
OBJ = f1.o f2.o main.o
.PHONY: test2
test2: $(OBJ)
	gcc $(OBJ) -o main.bin

%.o: %.c
	gcc -c $< -o $@

.PHONY: clean
clean: *.o *.bin
	rm *.o *.bin


