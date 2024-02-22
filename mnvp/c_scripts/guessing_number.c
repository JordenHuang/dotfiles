#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int set_real_ans(int min, int max);
int check_valid(int min, int max);

int main(void){
	int max, min, real_ans, user_guess=-1;
	char try_again, a;
	int count=0;

	while (count<100){
        count++;
		printf("Welcome to 終極密碼\n");
		printf("Enter the minimum: ");
		scanf("%d", &min);
		printf("Enter the maximum: ");
		scanf("%d", &max);

		if (check_valid(min, max)==0){
			printf("Not valid minimum and maximum!\n");
			continue;
		}

		real_ans=set_real_ans(min, max);
		
		system("clear");

		printf("The real answer is: %d\n", real_ans);
		
		while (user_guess!=real_ans){
			printf("Enter your guess (%d~%d): ", min, max);
			scanf("%d", &user_guess);
			if (user_guess<min || user_guess>max || user_guess==max || user_guess==min){
				printf("Out of range!! Please enter in the correct range!\n");
				continue;
			}
			else if (user_guess<real_ans){
				min=user_guess;
				printf("PASS!\n");
				continue;
			}
			else if (user_guess>real_ans){
				max=user_guess;
				printf("PASS!\n");
				continue;
			}
			else{
				printf("BOOM!!!\n");
			}
		}

		printf("To leave, enter 'q', or it will continue: ");

		//fflush(stdin);
//Linux下的gcc沒有定義fflush

		while ((a = getchar()) != EOF && a != '\n');
//不停地使用getchar()獲取緩衝中字元，直到獲取的c是“\n”或檔案結尾符EOF為止

		//scanf("%c", &a);
		scanf("%c", &try_again);
		if (try_again=='q'){
			printf("Quit");
			break;
		}
		else{
			printf("Continue~\n");
		}
	}

}


int check_valid(int min, int max){
	if (max-min<2){
		return 0;
	}
	else if (min<max){
		return 1;
	}
	
	return 0;
}

int set_real_ans(int min, int max){
	int real_ans;
	min++;
	max--;
	
	srand(time(NULL));
	
	real_ans=rand() % (max-min+1) + min;
	
	return real_ans;
}
