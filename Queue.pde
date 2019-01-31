//Made by Ian Martin, August 2018

//Just a simple struct
class cellintpair
{
  Cell first;
  int second;
  cellintpair(Cell C, int data)
  {
    first = C;
    second = data;
  }
}

//Simple Priority Queue system
class CellQueue
{
  ArrayList<cellintpair> data;
  CellQueue()
  {
    data = new ArrayList<cellintpair>();
  }

  void push(Cell C, int num)
  {
    for(int i = 0; i < data.size(); i++)
    {
      if(num > data.get(i).second)
      {
        data.add(i, new cellintpair(C, num)); 
        return;
      }
    }
    data.add(new cellintpair(C, num));
  }

  Cell pop()
  {
    cellintpair C = data.get(0);
    data.remove(0);
    return C.first;
  }

  boolean empty()
  {
    if (data.size() > 0)
    {
      return false;
    }
    return true;
  }
}
