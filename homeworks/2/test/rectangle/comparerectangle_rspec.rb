require_relative "../../lib/rectangles/comparerectangle.rb"
describe CompareRect, "Basic testing" do
    it "2 identical rectangle are intersect " do
      rct1 = (RectangleM.new(3,5,4))
      rct2 = (RectangleM.new(3,5,4))
      cmp = CompareRect.new
      
      cmp.compare(rct1,rct2).should == true
    end
    
    it "2 different rectangle without intersect " do
      rct1 = (RectangleM.new(3,5,4))
      rct2 = (RectangleM.new(12,5,4))
      cmp = CompareRect.new
      
      cmp.compare(rct1,rct2).should == false
    end
    it "2 different rectangle with intersect " do
      rct1 = (RectangleM.new(3,5,4))
      rct2 = (RectangleM.new(7,5,4))
      cmp = CompareRect.new
      
      cmp.compare(rct1,rct2).should == true
    end
    
    it "Size of area is correct " do
      rct1 = (RectangleM.new(3,5,4))
      rct2 = (RectangleM.new(6,5,4))
      cmp = CompareRect.new
      
      cmp.obsah(rct1,rct2).should == 28
    end
    
    it "Size of area is correct [0,0,4],[2,2,2]" do
      rct1 = (RectangleM.new(0,0,4))
      rct2 = (RectangleM.new(2,2,2))
      cmp = CompareRect.new
      
      cmp.obsah(rct1,rct2).should == 19
    end

    it "Size of area is correct [0.000,0.000e-3,4.0],[-2,-2e0,2.0e+0]" do
      rct1 = (RectangleM.new(0.000,0.000e-3,4.0))
      rct2 = (RectangleM.new(-2,-2e0,2.0e+0))
      cmp = CompareRect.new
      
      cmp.obsah(rct1,rct2).should == 19
    end


end
