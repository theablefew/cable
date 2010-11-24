SimpleNavigation::Configuration.run do |navigation|  
  navigation.items do |admin|
    admin.item :admin, "Home", '/admin'
    admin.item :menu, "Menu", admin_menus_path    
    admin.item :pages, 'Content', admin_pages_path do |content|
      
      content.item :pages, 'Page', admin_pages_path do |pages|
        pages.item :new, 'New Page', new_admin_page_path
      end

      content.item :static_pages, 'Static Page', admin_static_pages_path do |pages|
        pages.item :new, 'New Static Page', new_admin_static_page_path
      end

      content.item :news, 'News', admin_news_posts_path do |news|
        news.item :new, 'New News Post', new_admin_news_post_path
      end      

      content.item :success_stories, 'Success Stories', admin_success_stories_path do |success_stories|
        success_stories.item :new, 'New Story', new_admin_success_story_path
      end

      content.item :profiles, 'Profiles', admin_profiles_path do |profiles|
        profiles.item :new, 'New Profile', new_admin_profile_path
      end
      content.item :case_studies, 'Case Studies', admin_case_studies_path do |case_studies|
        case_studies.item :new, 'New Case Study', new_admin_case_study_path
      end
      content.item :products, 'Products', admin_products_path do |products|
        products.item :new, 'New Product', new_admin_product_path
      end
      content.item :events, 'Events', admin_events_path do |events|
        events.item :new, 'New Event', new_admin_event_path
      end    
       content.item :testimonials, 'Testimonials', admin_testimonials_path do |testimonials|
          testimonials.item :new, 'New Testimonial', new_admin_testimonial_path
        end  
        
      content.item :organization_logos, "Community Support", admin_organization_logos_path do |org_logos|
        org_logos.item :new, "New Organization ", new_admin_organization_logo_path
      end
    end
    admin.item :marquee, "Blocks and Maruquees", admin_marquees_path do |special|
      special.item :blocks, 'Blocks', admin_blocks_path do |blocks|
        blocks.item :new, 'New Block', new_admin_block_path
      end
      special.item :marquees, 'Marquees', admin_marquees_path do |marquees|
        marquees.item :new, 'New Marquee', new_admin_marquee_path
      end
    end
    admin.item :global_setting, 'Global Settings', admin_global_settings_path do |global_settings|
      global_settings.item :edit, "Edit Global Settings", edit_admin_global_setting_path( GlobalSetting.last )
    end
  end
end