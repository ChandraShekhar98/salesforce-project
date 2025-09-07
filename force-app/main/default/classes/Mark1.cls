public class Mark1 {
    public static String getString(Integer num) {
        Integer inp = num;
        Integer curRes = 0;
        String res = '';
        Integer temp = 0;
        Integer dist = 0;
        List<Integer> ls = new List<Integer>{1,3,9,27,81,243};
            while(curRes!=num) {
                for(Integer i = 0; i< ls.size(); i++) {
                    if(ls[i] > inp) {
                        temp = ls[i-1];
                        res += temp+'+';
                        curRes += temp;
                        dist = inp-temp;
                        inp = dist;
                        break;
                    } else if (ls[i] < inp) {
                        temp = ls[i+1];
                        res+= temp+'-';
                        curRes += temp;
                        dist = inp+temp;
                        inp=dist;
                        break;
                    } 
                }
            }  
        return res;
    }
}