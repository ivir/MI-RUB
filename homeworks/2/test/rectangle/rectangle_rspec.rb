require_relative "../../lib/rectangles/rectangle.rb"
describe RectangleM, "Basic testing" do
    it "Left corner for [3,5] and l=4 should be .... " do
      ts = (RectangleM.new(3,5,4))
      ts.leftdown.should == [1,3]
    end
    
    it "Right corner for [3,5] and l=4 should be .... " do
      ts = (RectangleM.new(3,5,4))
      ts.rightdown.should == [5,3]
    end
    
    it "Left up corner for [3,5] and l=4 should be .... " do
      ts = (RectangleM.new(3,5,4))
      ts.leftup.should == [1,7]
    end
    
    it "Left down corner for [3,5] and l=4 should be .... " do
      ts = (RectangleM.new(3,5,4))
      ts.rightup.should == [5,7]
    end
    
end