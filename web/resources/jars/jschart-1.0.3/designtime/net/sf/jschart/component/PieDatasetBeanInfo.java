package net.sf.jschart.component;

import com.sun.rave.designtime.Constants;
import java.beans.BeanDescriptor;
import java.beans.PropertyDescriptor;
import net.sf.jschart.util.CategoryDescriptors;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class PieDatasetBeanInfo extends AbstractBeanInfo
{
    private static Log log = LogFactory.getLog(PieDatasetBeanInfo.class);
    
    public PieDatasetBeanInfo()
    {
        beanClass = PieDataset.class;
        beanInfoClass = PieDatasetBeanInfo.class;
        setIcons("PieDataset");
        try
        {
            PropertyDescriptor pd;
            pd = addPropertyDescriptor("byColumn", null,
                    CategoryDescriptors.APPEARANCE, BOOL);
            pd = addPropertyDescriptor("dataProvider", "com.sun.rave.propertyeditors.SelectOneDomainEditor",
                    CategoryDescriptors.DATA, 0);
            pd.setValue("com.sun.rave.propertyeditors.DOMAIN_CLASS",
                    loadClass("com.sun.rave.propertyeditors.domains.InstanceVariableDomain"));
        }
        catch (Exception e)
        {
            log.error("Unexpected", e);
        }
    }
    
    public BeanDescriptor getBeanDescriptor()
    {
        if (beanDescriptor == null)
        {
            beanDescriptor = new BeanDescriptor(beanClass);
            beanDescriptor.setDisplayName(getMessage("PieDataset_DisplayName"));
            beanDescriptor.setShortDescription(getMessage("PieDataset_Description"));
            beanDescriptor.setExpert(false);
            beanDescriptor.setHidden(false);
            beanDescriptor.setPreferred(false);
            beanDescriptor.setValue(Constants.BeanDescriptor.FACET_DESCRIPTORS, getFacetDescriptors());
            beanDescriptor.setValue(Constants.BeanDescriptor.INSTANCE_NAME, "pieDataset");
            beanDescriptor.setValue(Constants.BeanDescriptor.IS_CONTAINER, Boolean.FALSE);
            beanDescriptor.setValue(Constants.BeanDescriptor.PROPERTY_CATEGORIES, getCategoryDescriptors());
        }
        return beanDescriptor;
    }
}
