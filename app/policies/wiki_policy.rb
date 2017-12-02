# class WikiPolicy < ApplicationPolicy
#
#   def initialize(user, wiki)
#     @user = user
#     @wiki = wiki
#   end
#
#   def show?
#     !@wiki.private? || @user.present? && (@wiki.user_id == @user.id || @user.admin? || @user.premium? || @wiki.users.include?(@user.id))
#   end
#
#   def edit?
#     @user.present? && (@user.admin?) # || @wiki.users.include?(@user.id))
#   end
#
#   def destroy?
#     user && (@user.admin? || @wiki.user_id == @user.id)
#   end
#
#   class Scope < Scope
#     attr_reader :user, :Scope
#
#     def initialize(user, scope)
#       @user = user
#       @scope = scope
#     end
#
#     def resolve
#       wikis = []
#       if user.present?
#         if user.role == 'admin'
#           wikis = scope.all
#       elsif user.present? && user.role == 'premium'
#         all_wikis = scope.all
#         all_wikis.each do |wiki|
#           if !wiki.private? || wiki.user == user #|| wiki.users.include?(user_id: user.id)
#             wikis << wiki
#           end
#         end
#       else
#         all_wikis = scope.all
#         all_wikis.each do |wiki|
#           if !wiki.private? #|| wiki.users.include?(user_id: user.id)
#             # if wiki.users.include?(user_id: user.id)
#             #   puts "\n\nNon Premium Collaborator Found\n\n"
#             # end
#             wikis << wiki
#           end
#         end
#       end
#       wikis
#     end
#   end
# end
# end
