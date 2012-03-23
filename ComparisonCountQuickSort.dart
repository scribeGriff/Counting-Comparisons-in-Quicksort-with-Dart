#import('dart:io');

class CountComparisonsQuicksort {
  //Counting comparisons with Quicksort
  int count;
  //Constructor function initializes arrays to be sorted/counted.
  CountComparisonsQuicksort(String fileName, String pivotType) {
    count = 0;
    File fileHandle = new File(fileName);
    //Read in list from a file.  Data is read in as strings.
    List<String> buffer = fileHandle.readAsLinesSync();
    //Create new buffer and parse number strings as integers.
    List<int> intBuffer = new List(buffer.length);
    for (var i = 0; i < buffer.length; i++) {
      intBuffer[i] = Math.parseInt(buffer[i]);
    }
    //Print unsorted array if desired.
    //print("$intBuffer");
    //Call sort routine
    sort(intBuffer, pivotType);
    //Print sorted array if desired.
    //print("$intBuffer");
    print("Quicksort made $count comparisons using $pivotType element method");
  }
  
  //Just calls recursive algorithm quicksort() and passes array, size and
  //pivot method.
  void sort(List<int> myArray, String pivotType) {
    quicksort(myArray, 0, myArray.length-1, pivotType);
  }
  
  //Recursive calls through quicksort now also keeps track of # of comparisons.
  void quicksort(List<int> inArray, int lo, int hi, String pivotType) {
    if (hi <= lo) return;
    count += (hi - lo);
    int pivot = partition(inArray, lo, hi, pivotType);  
    quicksort(inArray, lo, pivot-1, pivotType);  //Sort left part a[lo .. i-1]. 
    quicksort(inArray, pivot+1, hi, pivotType);  //Sort right part a[i+1 .. hi].
  }
  //The partition algorithm as outlined in class.  Using alternative
  //approaches (see, for example, https://github.com/financeCoding/
  //dart-sorting-algorithms/blob/master/src/QuickSort/QuickSort.dart) 
  //will produce the wrong number of comparisons for this assignment. 
  int partition(List<int> array, int lo, int hi, String pivotType) {
    //Preprocess pivot depending on method.
    if (pivotType == "last") {
      swap(array, lo, hi);
    } else if (pivotType == "median") {
      median3(array, lo, hi);
    }
    //Always set pivot to first element after preprocessing. 
    int pivot = array[lo];
    int i = lo+1;
    int j;
    //Scan subarray and sort according to <, > pivot.
    for (j = lo+1; j <= hi; j++) {
      if (array[j] < pivot) {
        swap(array, i, j);
        i++;
      }
    }
    //Set up new pivot point.
    swap(array, lo, i-1); 
    return i-1;
  }
  
  //Swap two entries in an array:
  void swap(List<int> array, int i, int j) { 
    int temp = array[i]; 
    array[i] = array[j]; 
    array[j] = temp; 
  }
  
  //The following median of 3 selection method is required to return
  //the same number of comparisons as the assignment solution.
  void median3(List<int> array, int lo, int hi) {
    int mid = ((lo + hi)/2).toInt();
    int small, median, large;
    if (array[lo] > array[mid]) {
      large = lo;
      small = mid;
    } else {
      large = mid;
      small = lo;
    }
    if (array[hi] > array[large]) {
      median = large;
    } else if (array[hi] < array[small]) {
      median = small;
    } else {
      median = hi;
    }
    swap(array, lo, median);
  }
  
  //The more common approach but one that will provide a different
  //number of comparisons than the answer key.
  void median3Alt1(List<int> array, int lo, int hi) {
    int mid = ((lo + hi)/2).toInt();
    if (array[mid].compareTo(array[lo]) < 0 )
      swap(array, lo, mid);
    if (array[hi].compareTo(array[lo]) < 0 )
      swap(array,lo, hi);
    if (array[hi].compareTo(array[mid]) < 0 )
      swap(array, mid, hi);
    swap(array, lo, mid);
  }
  //Or if you prefer, you can write Alt1 as follows:
  void median3Alt2(List<int> array, int lo, int hi) {
    int mid = ((lo + hi)/2).toInt();
    if (array[mid] < array[lo]) swap(array, lo, mid);
    if (array[hi] < array[lo]) swap(array,lo, hi);
    if (array[hi] < array[mid]) swap(array, mid, hi);
    swap(array, mid, lo);
  }
}

void main() {
  //Quicksort
  //Second project for Design & Analysis of Algorithms I 
  //Key:
  //first: Use 1st element of array as pivot
  //last: Use last element of array as pivot
  //median: Use median of 3 values of array as pivot
  //File from Design & Analysis of Algorithms I.  Contains 10,000 entries.
  String filename = "../QuickSort.txt";
  new CountComparisonsQuicksort(filename, "first");
  new CountComparisonsQuicksort(filename, "last");
  new CountComparisonsQuicksort(filename, "median");
}