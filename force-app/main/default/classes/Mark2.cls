public class Mark2 {
    public static Integer getString(Integer num) {
        List<Integer> ls = new List<Integer>{1,3,9,27,81,243};
        Integer counter = 0;
        Integer inp = num;
        Integer curRes = 0;
        Integer temp = 0;
        Integer dist = 0;
        while(curRes!=num) {
            for(Integer i = 0; i< ls.size(); i++) {
                if(ls[i] > inp) {
                    if(ls[i]-inp > inp-ls[i-1] || ls[i]-inp == inp-ls[i-1]){
                        temp = ls[i-1];
                        curRes += temp;
                        dist = inp-temp;
                        inp = dist;
                        break;
                    } else {
                        counter++;
                        temp = ls[i];
                        if(counter == 1){
                        	curRes += temp;
                        } else {
                           curRes -= temp; 
                        }
                        dist = inp-temp;
                        inp = -(dist);
                        break;
                    }
                } 
            }
            if(inp == 0){
                break;
            }
        }
        return curRes;   
    }
}