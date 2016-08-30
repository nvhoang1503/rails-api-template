var TestUtils = React.addons.TestUtils;

describe("Pager", function() {
    var component;
    describe("Current page is 2", function() {
        beforeEach(function() {
            component = TestUtils.renderIntoDocument(
                Pager({
                  totalPages: 11,
                  currentPage: 2,
                  windowSize: 3
                })
            );
        });

        it("should render buttons: 1, 2, 3 ", function() {
            var c =  $(ReactDOM.findDOMNode(component))
            expect(c.find(".item__page-btn").length).toBe(3);
            expect(c.find(".item__page-btn:eq(0)").text()).toBe('1');
            expect(c.find(".item__page-btn:eq(1)").text()).toBe('2');
            expect(c.find(".item__page-btn:eq(2)").text()).toBe('3');

        });

        it("should have button 2 as active button", function() {
            var c =  $(ReactDOM.findDOMNode(component))
            expect(c.find(".item__page-btn:eq(1)").attr("class")).toContain("active")
        });

        it("should not have previous segment button", function() {
            var c =  $(ReactDOM.findDOMNode(component))
            expect(c.find(".item__previous-segment-btn").length).toBe(0)
        });

        it("should have next segment button", function() {
            var c =  $(ReactDOM.findDOMNode(component))
            expect(c.find(".item__next-segment-btn").length).toBe(1)
        });
    });
    describe("Current page is 5", function() {
        beforeEach(function() {
            component = TestUtils.renderIntoDocument(
                Pager({
                    totalPages: 11,
                    currentPage: 5,
                    windowSize: 3
                })
            );
        });

        it("should render buttons: 4, 5, 6 ", function() {
            var c =  $(ReactDOM.findDOMNode(component))
            expect(c.find(".item__page-btn").length).toBe(3);
            expect(c.find(".item__page-btn")[0].textContent).toBe('4');
            expect(c.find(".item__page-btn")[1].textContent).toBe('5');
            expect(c.find(".item__page-btn")[2].textContent).toBe('6');
        });

        it("should have button 5 as active button", function() {
            var c =  $(ReactDOM.findDOMNode(component))
            expect(c.find(".item__page-btn:eq(1)").attr("class")).toContain("active")
        });

        it("should have previous segment button", function() {
            var c =  $(ReactDOM.findDOMNode(component))
            expect(c.find(".item__previous-segment-btn").length).toBe(1)
        });

        it("should have next segment button", function() {
            var c =  $(ReactDOM.findDOMNode(component))
            expect(c.find(".item__next-segment-btn").length).toBe(1)
        });
    });
    describe("Current page is 10", function() {
        beforeEach(function() {
            component = TestUtils.renderIntoDocument(
                Pager({
                    totalPages: 11,
                    currentPage: 10,
                    windowSize: 3
                })
            );
        });

        it("should render buttons: 10, 11 ", function() {
            var c =  $(ReactDOM.findDOMNode(component))
            expect(c.find(".item__page-btn").length).toBe(2);
            expect(c.find(".item__page-btn")[0].textContent).toBe('10');
            expect(c.find(".item__page-btn")[1].textContent).toBe('11');
        });

        it("should have button 10 as active button", function() {
            var c =  $(ReactDOM.findDOMNode(component))
            expect(c.find(".item__page-btn:eq(0)").attr("class")).toContain("active")
        });

        it("should have previous segment button", function() {
            var c =  $(ReactDOM.findDOMNode(component))
            expect(c.find(".item__previous-segment-btn").length).toBe(1)
        });

        it("should not have next segment button", function() {
            var c =  $(ReactDOM.findDOMNode(component))
            expect(c.find(".item__next-segment-btn").length).toBe(0)
        });
    });
});
