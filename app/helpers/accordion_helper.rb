module AccordionHelper
  def accordion_item extra_class: "", icon: "", price: "", payment: "", &content
    tag.div class: "accordion__item #{ extra_classes }" do
      tag.div class: "accordion__header" do
        tag.div class:"accordion__name" do

          tag.div class: "name__icon" do
            tag.i class: "material-icons" do
              icon
            end
          end

          tag.div class: "name__about" do
            tag.span class: "name__price" do
              price
            end

            tag.span class: "name__payment" do
              payment
            end
          end

          tag.i class: "material-icons accordion__arrow" do
            "keyboard_arrow_down"
          end
        end
      end

      tag.div class: "accordion__content" do
        tag.div class: "accordion__innerContent" do
          tag.div class: "accordion__message" do
            yield content if content
          end
        end
      end
    end
  end
end
